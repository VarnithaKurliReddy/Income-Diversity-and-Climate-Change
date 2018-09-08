clear all
set more off
set matsize 1000
set scheme s1color
set logtype text
capture log close
log using "/Users/varnithakurli/Desktop/ICRISAT - VDSA Data/Crop Diversification/Diversity Sources/Monthly1.0.log",replace
*Others-Type of the product, income, and place where it is sold
*Livestock-Milk, Ghee, Selling Animals, Dung,Poultry, Animals received, Leased Out,Fish,SilkWorm.
*Crop-Income crop, Type of crop
*Loan:Non-Inst:SHG's,Money Lenders etc.,
*Inst:MicroFinance, Commerical Banks, Some SHG's,Cooperatives,Insurance Dept
*Interest Rates
*Financial Transactions-gifts&remittances,receipts,savings and deposits,Source,
*Wages:Farm activity,Unskilled labor,Salaried Job.
*Migrant status, Type of work-Fram or non farm
use "/Users/varnithakurli/Desktop/ICRISAT - VDSA Data/Crop Diversification/Diversity Sources/Monthly1.0.dta"
*1-mahabubnagar,2-prakasam,3-patna,4-darbhanga,5-panchmahal,6-junagadh,7-ranchi,8-dumka,9-tumkur,10-bijapur,11-solapur,12-akola,13-raisen,14-bolangir,15-dhenkanal
*1-Aurepalle,2-dokur,3-j.c.agraharem,4-pamidipadu,5-arap,6-baghakole,7-inai,8-susari,9-babrol,10-chatha,11-kalamdi chingariya,12-makhiyala,13-dubaliya,14-dumariya,15-durgapur,16-belladamandgel,17-kappanimbargi,18-markabbinahalli,19-tharati,20-kalman,21-kanzara,22-kinkheda,23-shirapur,24-papda,25-rampur kalan,26-ainlatunga,27-bilaikani,28-chandrashekarpur,29-sogar
graph box number_sources effective_sources, over(pre_farm_size)
graph box number_sources effective_sources, over(state)
sunflower effective_sources number_sources 
spearman effective_sources number_sources
inspect effective_sources
inspect effective_sources_l
oneway effective_sources pre_farm_size,tabulate
oneway effective_sources state,tabulate
pwmean effective_sources, over(pre_farm_size) effects
pwmean effective_sources, over(state) effects
log close
