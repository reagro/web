
library(agrins)
d <- data_rice("origyield")
d[,1] <- as.character(d[,1])
d[,2] <- as.character(d[,2])
d[d[,1] == "", 1] = "Other"

head(d, n=2)

v = c('zone_grp','zone','fid','year','y_it','y_it_pct','y_i','y_zt','y_z','idx_ndvi1','idx_evi','idx_gpp','idx_et','idx_lai')

d <- d[,v]
colnames(d)[1] = "region"
d <- d[order(d$region, d$zone, d$fid, d$year), ]

d1 = d[,1:5]
colnames(d1)[5] = "y"
d2 = d[, c(1:2, 4, 10:14)]
colnames(d2) = gsub("idx_", "", colnames(d2))
colnames(d2)[4] = "ndvi"
ad2 <- aggregate(d2[,4:8], d2[,1:3], mean, na.rm=TRUE)
ad2 <- ad2[order(ad2$region, ad2$zone, ad2$year), ]

yield <- na.omit(d1)
zoneidx <- ad2


saveRDS(yield, "rice_yield.rds")
saveRDS(zoneidx, "rice_idx.rds")

idx <- data_rice("indices")
head(idx, n=3)

