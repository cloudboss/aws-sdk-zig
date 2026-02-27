pub const SourceConnectorType = enum {
    salesforce,
    marketo,
    zendesk,
    servicenow,
    s3,

    pub const json_field_names = .{
        .salesforce = "SALESFORCE",
        .marketo = "MARKETO",
        .zendesk = "ZENDESK",
        .servicenow = "SERVICENOW",
        .s3 = "S3",
    };
};
