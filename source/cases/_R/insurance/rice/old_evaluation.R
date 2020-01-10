

```{r ins1}
trigger <- 0.8
markup  <- 0.25
rho     <- 1.5
#' param y is the zone's income at time t
#' param mu is the zone's long-term average
payout <- function(y , mu){
  ifelse(y < (trigger * mu),
         (trigger * mu) - y,
         0)
}

```
Let us prepare the data for all zones and compute their income.

```{r ins2, message=FALSE}
library(agrins)
d <- data_rice("yield")
head(d)
z <- d
z <- z[complete.cases(z$y_zt) & z$y_zt != 0 , ]
#compute income
z$y <- z$y_zt * 0.35
#compute long-term average income for each zone
u <- unique(z$zone)
z$mu <- NA
for(i in 1:length(u)){
  z$mu[z$zone==u[i]] <- mean(z$y[z$zone==u[i]], na.rm=T)
}

```

Compute payouts based for each zone.

```{r ins3}
z$payouts <- NA
z$payouts <- payout(z$y, z$mu)

```

Let us now compute insurance premium paid by every farmer in a zone *z*. Normally the insurance is marked up to cater for administrative costs. From the perspective of the client, a contract is **actuarially fair** if the premiums paid are equal to the expected value of compensation (payouts) paid. Therefore, we can estimate the premium from the average payouts received by a  client multiplied by some mark-up. 

```{r ins4}
library(dplyr)
options(warn = 1)
z$premium <- NA
z <- ungroup(mutate(group_by(z, zone), 
                    premium = mean(payouts, na.rm=T)* (1 + markup)))

```
Compute each zones income with insurance; note that you need to subtract the cost of the premium from income (this is an expense). Then plot make plots of income with and without insurance. What do you learn?

```{r ins5, out.width = '100%'}
z$income_with_ins <- NA
z$income_with_ins <-  z$y + z$payouts - z$premium
layout(matrix(c(1:4), 2, 2) )
par(mar = c(2, 2, 2.5, 2.1))
for(i in 1:length(u)){
  income <- z$y[z$zone==u[i]]
  income_with_insurance <- z$income_with_ins[z$zone==u[i]]
  plot(income, income, col="red",  xlim=range(income), ylim=range(income), type="l", xlab="incomes[$]", ylab="incomes[$]", main=u[i])
  lines(sort(income), sort(income_with_insurance), xlim=range(income), ylim=range(income_with_insurance), type="l", col="green")
  legend("bottomright", lty = 1, col = c("red", "green"), legend=c('No insurance','With insurance'), title="Type")

}

```
We can observe that insurance never made much difference to people in Ndungu East and South as the plot for income with and without insurance coincide. In contrast, insurance cushioned farmers during bad states of the world (low yield/income). During the good states of the world income of a farmer with insurance was lower than without because an individual incurs insurance premium cost.

The next thing we wish to evaluate is if this insurance scheme was beneficial at all to farmers. Get utility and CE function from [previous section](introduction.html) as below.

```{r CE01}
utility <- function(income, rho) {
  if (rho==1) {
    log(income)
  } else {
    (income ^ (1 - rho)) / (1 - rho)
  }
}

cert_equiv <- function(expected_utility, rho){
	if (rho == 1) { 
		exp (expected_utility)
	} else {
		((1-rho) * expected_utility) ^ (1/(1-rho))
	}
}

ce_from_income <- function(income, rho){
	u <- mean(utility(income, rho), na.rm=T)
	cert_equiv(u, rho)
}

```

Compute CE with and without insurance.

```{r ins6}
z$ce_no_ins <- NA
z$ce_with_ins  <- NA 
for(i in 1:length(u)){
  income_no_ins   <- z$y[z$zone==u[i]]
  income_with_ins <- z$income_with_ins[z$zone==u[i]]
  z$ce_no_ins[z$zone==u[i]] <- ce_from_income(income_no_ins, rho=1.5)
  z$ce_with_ins[z$zone==u[i]] <- ce_from_income(income_with_ins, rho=1.5)
}

```

Now let us determine if this insurance contract passes the welfare test ( -1 is bad, 0 is no effect, 1 is good) using Minimum Quality Standard (MQS) test. The MQS test goal is to answer the question; "would a household be better off without insurance or with insurance?" If the household would be better off economically buying insurance, then we will say that the insurance contract meets the Minimum Quality Standard (MQS) hence 1.

```{r mqs01}
mqs <- function(ce_with_ins, ce_no_ins) {
   m = sign(ce_with_ins - ce_no_ins)
   c("bad", "neutral", "good")[m+2]
}

```

Use the MQS function to perform welfare test. To accomplish this, we will use already computed CE with and without insurance using risk aversion values $0 \leq rho \leq 2$. 

```{r mqs02}
zones <- z[!duplicated(z$zone), ] 
zones$mqs_test <- NA
zones$mqs_test <- mqs(zones$ce_with_ins, zones$ce_no_ins)
zones[, c("zone","mqs_test")]
```

We can re-affirm as noted before that contract did not meet the welfare test in Ndungu East and South.

