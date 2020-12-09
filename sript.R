salud_oms = read.csv2(file = "data (1).csv", sep = ",") %>% data.frame(.)
happiness = read_excel(path = "./Chapter2OnlineData.xls", sheet = "Table2.1") %>% data.frame(.) %>% subset(.,Year == 2017)
data_bank_indicador = read.csv2(file = "./Data_Extract_From_World_Development_Indicators/7d4f75b5-8783-4868-a60f-5502b3e86d91_Data.csv", sep = ",") %>% data.frame(.)

salud_oms = salud_oms[-1,c(1,4,6,8,10,12)]

colnames(salud_oms)[1] = c("Country.name")
colnames(data_bank_indicador)[1] = c("Country.name")

salud_oms = salud_oms[salud_oms[,1] %in% happiness$Country.name == TRUE,]
happiness = happiness[happiness[,1] %in% salud_oms$Country.name == TRUE,]

data_bank_indicador = data_bank_indicador[1:(nrow(data_bank_indicador)-5),c(-2,-4)]
data_bank_indicador = reshape2::dcast(data = data_bank_indicador, formula =  Country.name ~ Series.Name , value.var="X2017..YR2017.")

data_bank_indicador = data_bank_indicador[data_bank_indicador[,1] %in% happiness$Country.name == TRUE,]
salud_oms = salud_oms[salud_oms[,1] %in% data_bank_indicador$Country.name == TRUE,]
happiness = happiness[happiness[,1] %in% data_bank_indicador$Country.name == TRUE,]

salud_happiness_prefinal = merge(x = salud_oms,y = happiness,by="Country.name")

base_datos_final = merge(x = salud_happiness,y = data_bank_indicador,by="Country.name")
