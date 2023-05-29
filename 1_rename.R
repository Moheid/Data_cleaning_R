# Project name: An Assessment of Tax Legislative Reform on Corporate Income Tax Compliance
# Data Cleaning: 29 May, 2023
# Date Modified: 29 May, 2023

# 1. Load the package 
# Checks if package is installed, installs if necessary, and loads package for current session
pacman::p_load(
  lubridate,  # general package for handling and converting dates  
  parsedate,   # has function to "guess" messy dates
  aweek,      # another option for converting dates to weeks, and weeks to dates
  zoo,        # additional date/time functions
  tidyverse,  # data management and visualization  
  rio)        # data import/export

#  2. TH LOAD DATA 
cleaning <- read.csv2('data/raw/raw.csv')
         # for everything good in R ;)
###############################################################################
# Add respodent ID 
###############################################################################

cleaning <- tibble::rowid_to_column(cleaning, "id")
view(cleaning)

# 2. EXPLORE THE DATA 
head(cleaning)
dim(cleaning)
str(cleaning)
View(cleaning)
names(cleaning)

# 4. Renaming Multiple Variables
# Time rename 5:54pm
renamed <- rename(cleaning,
                    "datetime" = "Timestamp",
                    "gender" = "X1..Select.your.gender",
                    "profession" = "X2.What.is.your.profession.role.", 
                    "age" = "X3.Select.your.age.group", 
                    "education" = "X4.Level.of.education",
                    "occupation" = "X1..What.is.your.occupation.",
                    "obligated" = "X2..What.are.the.obligated.taxes.on.corporate.business.",
                    "believed" = "X3..For.which.of.the.following.corporate.taxes.do.you.believe.a.significant.reform.is.needed.", 
                    "motivators" = "X4...What.are.the.key.motivating.factors.in.corporate.income.tax.legislative.reform.", 
                    "important" = "X5..Which.are.the.most.important.areas.in.corporate.legislative.tax.reform.", 
                    "changes" = "X6..Do.you.believe.that.the.legal.tax.reforms.can.be.translated.into.positive.change.in.practically.", 
                    "priorities" = "X7..Do.you.believe.that.the.corporate.legislative.tax.was.the.main.priorities.of.this.tax.reform.generally.", 
                    "implementation" = "X8..Does.the.corporate.legislative.tax.reform.is.implemented.as.intended.", 
                    "adaptation" = "X9..Does.the.communication.and.collaboration.among.reform.stakeholders.are.adopted.in.the.Tax.Reform.Process", 
                    "encouragement" = "X10..Improvement.of.corporate.tax.administration.encouraged.Self.Assessment.and.registration.of.corporate.companies.", 
                    "tin" = "X11..The.use.of.Tax.Identification.Number..TIN..assisted.corporate.income.tax.compliance.", 
                    "compliance" = "X12..The.administration.reform.of.corporate.income.tax..enabled.income.tax.compliance.", 
                    "knowledge" = "X13..The.administrative.tax.reforms.increased.taxpayer.knowledge.and.awareness.of.corporate.income.tax", 
                    "voluntary" = "X14..Since.of.corporate.income.tax.administrative.reformed..all.companies.voluntarily.file.their.tax.returns.promptly",
                    "comprehension" = "X15..The.present.tax.laws.and.policies.are.easy.comprehensive.and.understandable.", 
                    "taxpayer" = "X16..Do.you.believe.whether.reforms.have.led.to.lower.taxpayer.compliance.administrative.burdens.", 
                    "success" = "X17..In.your.own.opinion.what.is.the.overall.success.rate.of.various.administrative.tax.reform.measures.in.relation.to.corporate.compliance...Explain.", 
                    "bylaws" = "X18..The.corporate.tax.policies.and.legislatives.is.reformed.", 
                    "income" = "X19..The.tax.laws.have.increased.corporate.income.tax.compliance", 
                    "new_law" = "X20..The.new.tax.laws.increased.integrity.of.reports.filled.by.corporates", 
                   "decreased_audit" = "X21..The.introduction.of.tax.law.has.decreased.the.number.of.audit.and.transaction.costs.in.corporate.income.tax" ,  
                    "decreased_fines" = "X22..The.policy.tax.reforms.have.decreased.the.number.of.fines...penalties.on.corporate", 
                   "decreased_evaders" = "X23..The.corporate.policy.income.tax.reforms.have.decreased.the.number.of.corporate.tax.evaders.and.envisions." , 
                   "Reform_role" = "X24..Corporate.income.tax.reform.has.played.a.significant.role.in.voluntary.corporate.tax.compliance",
                   "complexity_necessity" = "X25..Complexity.in.tax.law...is.necessary.so.that.companies.are.treated.fairly.", 
                   "recommendation" = "X26..What.should.be.done.to.improve.the.business.taxation.through.this.reform.",
                   "challenges" = "X28..What.are.the.most.challenges.of.tax.legislative.reform.",
                   "acknowledge" = "Thank.you.so.much.for.your.time" 
                   )

view(renamed)

# Add label to your columns names
### Option 1: Add single item label 
attr(renamed[["gender"]], "label") <- "types of gender"
attr(renamed[["profession"]], "label") <- "Job titles"
attr(renamed[["age"]], "label") <- "age of respondent"
attr(renamed[["education"]], "label") <- "level of education"
attr(renamed[["occupation"]], "label") <- "profession title"
attr(renamed[["obligated"]], "label") <- "Q1.What are the obligated taxes on corporate business?"
attr(renamed[["believed"]], "label") <-  "Q2. For which of the following corporate taxes do you believe a significant reform is needed?"

view(renamed)
### Option 2: Add Multiple items labeled 
colnames(renamed)

library(Hmisc)
var.labels = c(age =  "age in years", 
               education = "Education levels",
               occupation = "Work areas",
               obligated_taxes = "What are the obligated taxes on corporate business"
               )
################################################################################

################################################################################
# 3. Rule of thumbnail is to standarize your column names, better to make lowers cases. 
################################################################################
renamed %>%
  janitor::clean_names() %>%
  names()
# Check Whether all names converted into lower cas
colnames(renamed)

################################################################################
# SAVE RENAMED COLUMN 
################################################################################
list.files(full.name = TRUE) # get the path file 
library(readr)
write_csv(renamed, "./data/processed/renamed.csv")
write_excel_csv(renamed, "./data/processed/renamed.xlsx")
saveRDS(renamed, "./scripts/renamed")

# File snapshot
snapshot <- fileSnapshot()
# File info
file.info("renamed.csv")

# CLEAN UP ENVIRONMENT 
## 1. Clear packages 
detach("packages:datasets", unload = TRUE)
## 2. Clear plot
dev.off()

#Clear console
cat("\014") # ctr/cmd + L

 # good practice to include sessionInfo
sessionInfo()


