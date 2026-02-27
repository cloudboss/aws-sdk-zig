pub const RetrievalResultLocationType = enum {
    s3,
    web,
    confluence,
    salesforce,
    sharepoint,
    custom,
    kendra,
    sql,

    pub const json_field_names = .{
        .s3 = "S3",
        .web = "WEB",
        .confluence = "CONFLUENCE",
        .salesforce = "SALESFORCE",
        .sharepoint = "SHAREPOINT",
        .custom = "CUSTOM",
        .kendra = "KENDRA",
        .sql = "SQL",
    };
};
