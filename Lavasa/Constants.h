




#define KDatabaseUpdateString @"www.google.com/sqlitevr2.0"
#define KGoogleAPIKey @"sfsfgqfffqqqqwrrtgwrgfg"
#define KSqliteDb @"Lavasa"

#define KGoogleClientID @"977277172019-g5lpd2gp197l5jkhconbd0ntge1mmpv1.apps.googleusercontent.com"

//SELECT rowid, place_type,place_name, icon_url, formatted_address FROM tbl_places  where place_type='food' and rowid not in ( SELECT rowid  FROM tbl_places   order by rowid limit 0,0 ) order by rowid limit 5


#define IS_iPHONE ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)


#define IS_iPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)




