center_scale <- function(x) {
  scale(x, scale = FALSE)
}

genotype <- read.table("./genotype_full.txt",header = T,row.names = 1);
genotype <- as.matrix(genotype);
pheno <- read.table("./pheno_left.txt",header=F);
pheno <- as.matrix(pheno);
pheno1 <- matrix(pheno[,2],ncol=1);

class(genotype) <- "numeric";
class(pheno1) <- "numeric";

geno1_filter <- genotype[pheno[,1],]
geno1_filter <- as.matrix(geno1_filter);

pheno_stand <- scale(pheno1);
geno_stand <- scale(geno1_filter);
ptm <- proc.time();

######Main effect-single locus:
sig_index = which(abs(t(pheno_stand) %*% geno_stand/nrow(geno_stand)) > 0.20);
geno_stand_main = geno1_filter[,sig_index];
geno_stand_main <- as.matrix(geno_stand_main);
sig_main <- NULL;
for(i in 1:ncol(geno_stand_main)){
  sole_geno = geno_stand_main[,i,drop=FALSE];
  model = lm(formula = pheno1 ~ sole_geno);
  modelsum = summary(model);
  modelCoeffs <- modelsum$coefficients;
  p_value =  modelCoeffs["sole_geno", "Pr(>|t|)"];
  beta = modelCoeffs["sole_geno", "Estimate"];
  sig_main=rbind(sig_main,matrix(c(colnames(sole_geno),beta,p_value),ncol = 3));
}

sig_epi_sum <- NULL;
for(k in 1:(ncol(geno1_filter)-1)){
  print(k);
  single_new = geno1_filter[,k,drop=FALSE];
  new=geno1_filter[,(k+1):ncol(geno1_filter)];
  new_combine = cbind(new,single_new);
  pseudo_allmat = transform(new_combine,subpseudo=new_combine[,1:(ncol(geno1_filter)-k)] * new_combine[,ncol(new_combine)]);
  colnames(pseudo_allmat) <- paste(colnames(pseudo_allmat), colnames(single_new),sep = "*");
  pseudo_mat = pseudo_allmat[,grep("subpseudo",colnames(pseudo_allmat)),drop=FALSE];
  pseudo_mat = as.matrix(pseudo_mat);
  pseudo_mat_stand = scale(pseudo_mat);
 
  epi_index = which(abs(t(pheno_stand) %*% pseudo_mat_stand/nrow(pseudo_mat_stand)) > 0.15);
  if(dim(as.matrix(epi_index))[[1]]!=0){
    pseudo_mat_stand_epi = pseudo_mat[,epi_index,drop=FALSE];
    sig_epi <- NULL;
    for(i in 1:ncol(pseudo_mat_stand_epi)){
      sole_geno = pseudo_mat_stand_epi[,i,drop=FALSE];
      model = lm(formula = pheno1 ~ sole_geno);
      modelsum = summary(model);
      modelCoeffs <- modelsum$coefficients;
      p_value =  modelCoeffs["sole_geno", "Pr(>|t|)"];
      beta = modelCoeffs["sole_geno", "Estimate"];
      sig_epi=rbind(sig_epi,matrix(c(colnames(sole_geno),beta,p_value),ncol = 3));
    }
    sig_epi_sum <- rbind(sig_epi_sum,sig_epi);
  }
}
proc.time()-ptm;

res <- rbind(sig_main,sig_epi_sum);
fdr = matrix(p.adjust(res[,3,drop=FALSE], method = "fdr"),ncol = 1);
fdr = format(fdr,sci=FALSE);
Blup <- cbind(res,fdr);
write.table(Blup,"Blup_real_res_0.18",quote=F,sep="\t",col.names = F,row.names = T)
