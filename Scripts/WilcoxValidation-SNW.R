#Validate the Wilcox Test Results 

############### Pre vs Post ###################### 

#Exp AKS
pre.exp.aks<-c(53,47,59,41,55,59,55,63,54,57)
post.exp.aks<-c(63,63,57,44,52,62,62.6666666666667,58,58,56)

wilcox.test(pre.exp.aks,post.exp.aks,paired = T, alternative = "less") 
#p-value result 0.092
#joe's code gives 0.1309413

#Con AKS
pre.con.aks<-c(52,56,59,59,59,59)
post.con.aks<-c(58,57,58,60,55,56)

wilcox.test(pre.con.aks,post.con.aks,paired = T, alternative = "less")

#Exp FACES
pre.exp.faces<-c(29,23,23,26,18,29,29,26,28,26)
post.exp.faces<-c(34,29,35,11,28,32,18,35,31,35)

wilcox.test(pre.exp.faces,post.exp.faces,paired = T, alternative = "less")

#Con FACES
pre.con.faces<-c(33,33,19,24,16,27)
post.con.faces<-c(33,31.8,25,23,14,26.8)

wilcox.test(pre.con.faces,post.con.faces,paired = T, alternative = "less")

#Exp FES
pre.exp.fes<-c(153,126,146,136,87,133,156,149,116,134)
post.exp.fes<-c(163,155,157,157,132,142,154.222222222222,162,124,160)

wilcox.test(pre.exp.fes,post.exp.fes,paired = T, alternative = "less")

#Con FES
pre.con.fes<-c(148,163,105,106,91,148)
post.con.fes<-c(149,163,116,102,97,155)

wilcox.test(pre.con.fes,post.con.fes,paired = T, alternative = "less")

#Exp FPPS 
#participant # 6, 8 removed 
pre.exp.fpps<-c(90,72,89,89,65,78,69,65)
post.exp.fpps<-c(90,85,87,87,73,90,63,67)

wilcox.test(pre.exp.fpps,post.exp.fpps,paired = T, alternative = "less")

#Con FPPS 
#participant # 18, and 19 removed 
pre.con.fpps<-c(66,35,60,67)
post.con.fpps<-c(67,49,56,74)

wilcox.test(pre.con.fpps,post.con.fpps,paired = T, alternative = "less")

#Exp SCS
#participant # 6, 8 removed 
pre.exp.scs<-c(28,25,29,33,17,23,18,31)
post.exp.scs<-c(33,33,29,34,24,24,19,34)

wilcox.test(pre.exp.scs,post.exp.scs,paired = T, alternative = "less")

#Con SCS
#participant # 18, and 19 removed 
pre.con.scs<-c(24,26,19,18)
post.con.scs<-c(27,29,35,16)

wilcox.test(pre.con.scs,post.con.scs,paired = T, alternative = "less")

#Exp SEAS
#participant # 6, 8 removed 
pre.exp.seas<-c(46,34,41,40,22,35,43,31)
post.exp.seas<-c(49,40,43,48,40,47,38,40)

wilcox.test(pre.exp.seas,post.exp.seas,paired = T, alternative = "less")

#Con SEAS
pre.con.seas<-c(43,44,24,32,47,26)
post.con.seas<-c(45,44,25,28,27,47)

wilcox.test(pre.con.seas,post.con.seas,paired = T, alternative = "less")


############### Experimental vs Control ###################### 
#Pre AKS
wilcox.test(pre.exp.aks,pre.con.aks,paired = F, alternative = "two.sided")
#p-value result 0.2897
#joe's code gives 0.3438231

#Post AKS
wilcox.test(post.exp.aks,post.con.aks,paired = F, alternative = "two.sided")

#Pre FACES
wilcox.test(pre.exp.faces,pre.con.faces,paired = F, alternative = "two.sided")

#Post FACES
wilcox.test(post.exp.faces,post.con.faces,paired = F, alternative = "two.sided")

#Pre FES
wilcox.test(pre.exp.fes,pre.con.fes,paired = F, alternative = "two.sided")

#Post FES
wilcox.test(post.exp.fes,post.con.fes,paired = F, alternative = "two.sided")

#Pre FPPS 
#participant # 6, 8 removed from Experimental
#participant # 18 and 19 removed from Control
wilcox.test(pre.exp.fpps,pre.con.fpps,paired = F, alternative = "two.sided")

#Post FPPS 
#participant # 6, 8 removed from Experimental
#participant # 18 and 19 removed from Control
wilcox.test(post.exp.fpps,post.con.fpps,paired = F, alternative = "two.sided")

#Pre SCS
#participant # 6, 8 removed from Experimental
#participant # 18 and 19 removed from Control
wilcox.test(pre.exp.scs,pre.con.scs,paired = F, alternative = "two.sided")

#Post SCS
#participant # 6, 8 removed from Experimental
#participant # 18 and 19 removed from Control
wilcox.test(post.exp.scs,post.con.scs,paired = F, alternative = "two.sided")

#Pre SEAS
#participant # 6, 8 removed from Experimental
#participant # 18 and 19 removed from Control
wilcox.test(pre.exp.seas,pre.con.seas,paired = F, alternative = "two.sided")

#Post SEAS
#participant # 6, 8 removed from Experimental
#participant # 18 and 19 removed from Control
wilcox.test(post.exp.seas,post.con.seas,paired = F, alternative = "two.sided")


