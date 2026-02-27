pub const DataSourceType = enum {
    s3,
    web,
    confluence,
    salesforce,
    sharepoint,
    custom,
    redshift_metadata,

    pub const json_field_names = .{
        .s3 = "S3",
        .web = "WEB",
        .confluence = "CONFLUENCE",
        .salesforce = "SALESFORCE",
        .sharepoint = "SHAREPOINT",
        .custom = "CUSTOM",
        .redshift_metadata = "REDSHIFT_METADATA",
    };
};
