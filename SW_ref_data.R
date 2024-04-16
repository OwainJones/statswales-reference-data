##################################################################################
#                                                                                #
# Register Dynamics                                                              #
#                                                                                #
# Project Title: StatsWales3                                                     #
# Name: StatsWales reference data                                                #
# Author: Owain Jones                                                            #
#                                                                                #
# Final version Date: 04/04/2024                                                 #
#                                                                                #
##################################################################################


###Output directory
dir_out = "G:/StatsWales/"

### Set start and end year
start_year = 1970
end_year = 2050

### use cmd line args if provided
args = commandArgs(trailingOnly = TRUE)

if (length(args) > 0) {dir_out=args[1]}


### Month generation

no_of_months = (end_year-start_year+1)*12

#Generate month IDs

month_IDs = c()
n = 0
j = start_year
i = 1

while (n < no_of_months) {
  if (i < 10) {
    k = paste(0,i,sep="")
  } else { k=i }
  m = paste(j,k,sep="-")
  month_IDs = c(month_IDs,m)
  if (i >= 12) {
    i = 1
    j = j+1
  } else {
    i = i+1
  }
  n = n+1
  }

month_ref = as.data.frame(month_IDs)


n = 0

months_eg = c("January",
              "February",
              "March",
              "April",
              "May",
              "June",
              "July",
              "August",
              "September",
              "October",
              "November",
              "December")

months_cy = c("Ionwar",
              "Chwefror",
              "Mawrth",
              "Ebril",
              "Mai",
              "Mehefin",
              "Gorffennhaf",
              "Awst",
              "Medi",
              "Hydref",
              "Tachwedd",
              "Rhagfyr")

abr_eg = c("Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "June",
            "July",
            "Aug",
            "Sept",
            "Oct",
            "Nov",
            "Dec")

abr_cy = c("Ion",
            "Chwef",
            "Maw",
            "Ebr",
            "Mai",
            "Meh",
            "Gorff",
            "Awst",
            "Medi",
            "Hyd",
            "Tach",
            "Rhag")

months_num = c("01","02","03","04","05","06","07","08","09","10","11","12")
quarters = c("Q1","Q2","Q3","Q4")

n = 1
num = character(length(month_IDs))
wel = character(length(month_IDs))
eng = character(length(month_IDs))
abbr_eg = character(length(month_IDs))
abbr_cy = character(length(month_IDs))
qtr = character(length(month_IDs))
cal = character(length(month_IDs))
fin = character(length(month_IDs))
acd = character(length(month_IDs))

while (n <= no_of_months) {
  month = substring(month_IDs[n], 6,7)
  year = substring(month_IDs[n], 1,4)
  mon = as.integer(month)
  yr = substring(month_IDs[n],3,4)
  y_num = as.integer(yr)
  
  if (y_num == 99) {
    y_plus = "00"
  }
  
  if (y_num < 9) {
    y_plus = paste(0,(y_num+1),sep="")
  } else {
    y_plus = y_num+1
  }
  
  num[n] = paste(month,year,sep="/")
  wel[n] = paste(months_cy[mon],year,sep=" ")
  eng[n] = paste(months_eg[mon],year,sep=" ")
  abbr_cy[n] = paste(abr_cy[mon],year,sep=" ")
  abbr_eg[n] = paste(abr_eg[mon],year,sep=" ")
  qtr[n] = paste(year,quarters[ceiling(mon/3)],sep="")
  cal[n] = year
  
  if (mon < 4) {
    fin[n] = paste(as.integer(year)-1,yr,sep="-")
  } else {
    fin[n] = paste(year,y_plus,sep="-")
  }
  
  if (mon > 8) {
    acd[n] = paste(year,y_plus,sep="-")
  } else {
    acd[n] = paste(as.integer(year)-1,yr,sep="-")
  }
  
  n = n+1
}

colnames(month_ref) = "month_id"

month_ref$desc_num = num
month_ref$desc_cy = wel
month_ref$desc_eg = eng
month_ref$abbr_cy = abbr_cy
month_ref$abbr_eg = abbr_eg
month_ref$quarter = qtr
month_ref$year_cal = cal
month_ref$year_fin = fin
month_ref$year_acd = acd

write.csv(month_ref,file=paste(dir_out,"month_ref.csv",sep=""),quote=TRUE,row.names=FALSE)

#Clean workspace
rm(list=setdiff(ls(), c("month_ref", "start_year","end_year","quarters","dir_out")))


### Quarter generation

no_of_quarters = (end_year-start_year+1)*4

#Generate quarter IDs

quarter_IDs = c()
n = 0
j = start_year
i = 1 #start quarter

while (n < no_of_quarters) {
  q = paste(j,quarters[i],sep="")
  quarter_IDs = c(quarter_IDs,q)
  if (i >= 4) {
    i = 1
    j = j+1
  } else {
    i = i+1
  }
  n = n+1
}

quarter_ref = as.data.frame(quarter_IDs)

n = 1
nm_eg = character(length(quarter_IDs))
nm_cy = character(length(quarter_IDs))
ab_eg = character(length(quarter_IDs))
ab_cy = character(length(quarter_IDs))
cal = character(length(quarter_IDs))
fin = character(length(quarter_IDs))

while (n <= no_of_quarters) {
  quarter = substring(quarter_IDs[n], 5,6)
  q_num = as.integer(substring(quarter_IDs[n],6))
  year = substring(quarter_IDs[n], 1,4)
  yr = substring(quarter_IDs[n],3,4)
  y_num = as.integer(yr)
  if (y_num == 99) {
    y_plus = "00"
  }
  
  if (y_num < 9) {
    y_plus = paste(0,(y_num+1),sep="")
  } else {
    y_plus = y_num+1
  }
  
  nm_eg[n] = paste("Quarter", q_num, year, sep=" ")
  nm_cy[n] = paste("Chwarter", q_num, year, sep=" ")
  ab_eg[n] = paste(paste("Q", q_num, sep=""),yr, sep="-")
  ab_cy[n] = paste(paste("C", q_num, sep=""),yr, sep="-")
  cal[n] = year
  if (q_num == 1) {
    fin[n] = paste(as.integer(year)-1,yr,sep="-")
  } else {
    fin[n] = paste(year,y_plus,sep="-")
  }
  n=n+1
}

colnames(quarter_ref) = "quarter_id"  

quarter_ref$name_cy = nm_cy
quarter_ref$name_eg = nm_eg
quarter_ref$abbr_cy = ab_cy
quarter_ref$abbr_eg = ab_eg
quarter_ref$year_cal = cal
quarter_ref$year_fin = fin

write.csv(quarter_ref,file=paste(dir_out,"quarter_ref.csv",sep=""),quote=TRUE,row.names=FALSE)

#Clean workspace
rm(list=setdiff(ls(), c("month_ref", "quarter_ref", "start_year","end_year","quarters","dir_out")))

### Date generation

day = 1
month = 1

months_eg = c("January",
              "February",
              "March",
              "April",
              "May",
              "June",
              "July",
              "August",
              "September",
              "October",
              "November",
              "December")

months_cy = c("Ionwar",
              "Chwefror",
              "Mawrth",
              "Ebrill",
              "Mai",
              "Mehefin",
              "Gorffenhaf",
              "Awst",
              "Medi",
              "Hydref",
              "Tachwedd",
              "Rhagfyr")

m_abbr_eg = c("Jan",
              "Feb",
              "Mar",
              "Apr",
              "May",
              "June",
              "July",
              "Aug",
              "Sept",
              "Oct",
              "Nov",
              "Dec")

m_abbr_cy = c("Ion",
              "Chwef",
              "Maw",
              "Ebr",
              "Mai",
              "Meh",
              "Gorff",
              "Awst",
              "Medi",
              "Hyd",
              "Tach",
              "Rhag")

date_IDs = c()

year = start_year

while (year <= end_year) {
  if (day<10) { day_txt = paste("0",day,sep="")} else {day_txt = day}
  if (month<10) {mth_txt = paste("0",month,sep="")} else {mth_txt=month}
  date_id = paste(year,mth_txt,day_txt,sep="")
  date_IDs = c(date_IDs,date_id)
  
  day = day+1
  if ((month==1 | month==3 | month==5 | month==7 | month==8 | month==10 | month==12) & day >31) {
    month = month+1
    day = day-31
  }
  
  if ((month==4|month==6|month==9|month==11) & day>30) {
    month = month+1
    day = day-30
  }
  if(month==2 & day>28 & (year%%4 != 0 | (year%%100 == 0 & year%%400 != 0))) {
    month = month+1
    day = day-28
  } else if(month==2 & day>29) {
    #print("leap")
    month = month+1
    day = day-29
  } 
  if (month > 12) {
    month = 1
    year = year+1
  }
}

date_ref = as.data.frame(date_IDs)

month_code = character(length(date_IDs))
year_code = character(length(date_IDs))
desc_num = character(length(date_IDs))
desc_eg = character(length(date_IDs))
desc_cy = character(length(date_IDs))
abbr_eg = character(length(date_IDs))
abbr_cy = character(length(date_IDs))
weekday_cy = character(length(date_IDs))
weekday_eg = character(length(date_IDs))

weekday_names_eg = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
weekday_names_cy = c("Dydd Llun","Dydd Mawrth","Dydd Mercher","Dydd Iau","Dydd Gwener","Dydd Sadwrn","Dydd Sul")
day_of_week = 4 #Looked up for 1970, Monday is 1

n=1

while (n<=length(date_IDs)) {
  year_code[n] = substring(date_IDs[n], 1,4)
  month_code[n] = paste(substring(date_IDs[n], 1,4),substring(date_IDs[n], 5,6),sep="-")
  month = substring(date_IDs[n], 5,6)
  date = substring(date_IDs[n], 7,8)
  year_abbr = substring(date_IDs[n], 3,4)
  m_num = as.integer(month)
  desc_num[n] = paste(date,month,year_code[n],sep="/")
  desc_cy[n] = paste(date,months_cy[m_num],year_code[n],sep=" ")
  desc_eg[n] = paste(date,months_eg[m_num],year_code[n],sep=" ")
  abbr_cy[n] = paste(date,m_abbr_cy[m_num],year_abbr,sep=" ")
  abbr_eg[n] = paste(date,m_abbr_eg[m_num],year_abbr,sep=" ")
  weekday_cy[n] = weekday_names_cy[day_of_week]
  weekday_eg[n] = weekday_names_eg[day_of_week]
  day_of_week = day_of_week+1
  if (day_of_week>7) { day_of_week = 1}
  n = n+1
}

colnames(date_ref) = "date_id"

date_ref$desc_num = desc_num
date_ref$desc_cy = desc_cy
date_ref$desc_eg = desc_eg
date_ref$abbr_cy = abbr_cy
date_ref$abbr_eg = abbr_eg
date_ref$day_of_week_cy = weekday_cy
date_ref$day_of_week_eg = weekday_eg
date_ref$month_id = month_code
date_ref$year_id = year_code



write.csv(date_ref,file=paste(dir_out,"date_ref.csv",sep=""),quote=TRUE,row.names=FALSE)

#Clean workspace
#rm(list=setdiff(ls(), c("month_ref", "quarter_ref", "week_ref", "date_ref", "start_year","end_year","quarters","dir_out")))
rm(list=ls())
