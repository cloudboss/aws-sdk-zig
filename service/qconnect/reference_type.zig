pub const ReferenceType = enum {
    web_crawler,
    knowledge_base,
    bedrock_kb_s3,
    bedrock_kb_web,
    bedrock_kb_confluence,
    bedrock_kb_salesforce,
    bedrock_kb_sharepoint,
    bedrock_kb_kendra,
    bedrock_kb_custom_document,
    bedrock_kb_sql,

    pub const json_field_names = .{
        .web_crawler = "WEB_CRAWLER",
        .knowledge_base = "KNOWLEDGE_BASE",
        .bedrock_kb_s3 = "BEDROCK_KB_S3",
        .bedrock_kb_web = "BEDROCK_KB_WEB",
        .bedrock_kb_confluence = "BEDROCK_KB_CONFLUENCE",
        .bedrock_kb_salesforce = "BEDROCK_KB_SALESFORCE",
        .bedrock_kb_sharepoint = "BEDROCK_KB_SHAREPOINT",
        .bedrock_kb_kendra = "BEDROCK_KB_KENDRA",
        .bedrock_kb_custom_document = "BEDROCK_KB_CUSTOM_DOCUMENT",
        .bedrock_kb_sql = "BEDROCK_KB_SQL",
    };
};
