


dates <- evifiles$date

png(filename = "C:/Users/anighosh/Pictures/phenoplot_tza.png", 
    width = 6, height = 5, res = 300, units = "in")

plot(dates, ts_evi[i,], pch = 16, col = "red", cex = 1, ylim = c(0,0.7), 
     xlab = "vegetation indices", ylab = "dates",
     main = paste0("location_",i))

# smoothed values
lines(dates, ts_fevi[i,], col = "green", lwd = 2)
lines(dates, ts_fndfi[i,], col = "blue", lwd = 2)

legend("topleft", legend = c("EVI (raw)", "EVI", "NDFI"),
       pch = c(16, NA, NA), lty = c(NA, 1, 1),
       col = c("red", "green", "blue"), bty = "n", cex = 1)
dev.off()


png(filename = "C:/Users/anighosh/Pictures/yield_index.png", 
    width = 7, height = 5, res = 300, units = "in")
plot(v1, type = "l", col = "darkgreen", ylim = c(min(v1), max(v1)*1.25), 
     ylab = "EVI", xlab = "date", xaxt = "n",
     main = "EVI based index")

at <- seq(1, length(v1), 4) 
labs <- months(dates[at])
axis(1, at = at, labels = substr(labs, 1,3), las = 2)

# vegetative
polygon(x=c(start,start:peak,peak), 
        y=c(0, v1[start:peak], 0), 
        col="green")

# grain-filling
polygon(x=c(peak, peak:mature, mature), 
        y=c(0, v1[peak:mature], 0), col="yellow")

# add full growing season
polygon(x=c(start,start:mature, mature), 
        y=c(0, v1[start:mature], 0), 
        col="red", density=10)

# add legend
legend("topleft", legend=c("vegetative","grain","full"), fill=c("green", "yellow", "red"), density=c(NA, NA, 20), bty="n", border="black")
dev.off()


png(filename = "C:/Users/anighosh/Pictures/spatial_agg.png", 
    width = 7, height = 5, res = 300, units = "in")
par(mfrow = c(1,2))
plot(arm[["idx_evi_v"]], main = "idx_evi_v", col=topo.colors(25), leg.levels=10)
plot(z, add = T)
plot(mzv, "idx_evi_v", main = "zone_level_metrics", 
     col=topo.colors(25), leg.levels=10)
dev.off()
