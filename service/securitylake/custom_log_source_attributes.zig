/// The attributes of a third-party custom source.
pub const CustomLogSourceAttributes = struct {
    /// The ARN of the Glue crawler.
    crawler_arn: ?[]const u8,

    /// The ARN of the Glue database where results are written, such as:
    /// `arn:aws:daylight:us-east-1::database/sometable/*`.
    database_arn: ?[]const u8,

    /// The ARN of the Glue table.
    table_arn: ?[]const u8,

    pub const json_field_names = .{
        .crawler_arn = "crawlerArn",
        .database_arn = "databaseArn",
        .table_arn = "tableArn",
    };
};
