const DataSourceConfiguration = @import("data_source_configuration.zig").DataSourceConfiguration;
const CustomDocumentEnrichmentConfiguration = @import("custom_document_enrichment_configuration.zig").CustomDocumentEnrichmentConfiguration;
const DataSourceVpcConfiguration = @import("data_source_vpc_configuration.zig").DataSourceVpcConfiguration;

pub const UpdateDataSourceRequest = struct {
    /// Configuration information you want to update for the data source connector.
    configuration: ?DataSourceConfiguration = null,

    /// Configuration information you want to update for altering document metadata
    /// and
    /// content during the document ingestion process.
    ///
    /// For more information on how to create, modify and delete document metadata,
    /// or make
    /// other content alterations when you ingest documents into Amazon Kendra, see
    /// [Customizing document metadata during the ingestion
    /// process](https://docs.aws.amazon.com/kendra/latest/dg/custom-document-enrichment.html).
    custom_document_enrichment_configuration: ?CustomDocumentEnrichmentConfiguration = null,

    /// A new description for the data source connector.
    description: ?[]const u8 = null,

    /// The identifier of the data source connector you want to update.
    id: []const u8,

    /// The identifier of the index used with the data source connector.
    index_id: []const u8,

    /// The code for a language you want to update for the data source connector.
    /// This allows you to support a language for all
    /// documents when updating the data source. English is supported
    /// by default. For more information on supported languages, including their
    /// codes,
    /// see [Adding
    /// documents in languages other than
    /// English](https://docs.aws.amazon.com/kendra/latest/dg/in-adding-languages.html).
    language_code: ?[]const u8 = null,

    /// A new name for the data source connector.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of an IAM role with permission to access
    /// the data source and required resources. For more information, see [IAM roles
    /// for Amazon
    /// Kendra](https://docs.aws.amazon.com/kendra/latest/dg/iam-roles.html).
    role_arn: ?[]const u8 = null,

    /// The sync schedule you want to update for the data source connector.
    schedule: ?[]const u8 = null,

    /// Configuration information for an Amazon Virtual Private Cloud to connect to
    /// your data source.
    /// For more information, see [Configuring a
    /// VPC](https://docs.aws.amazon.com/kendra/latest/dg/vpc-configuration.html).
    vpc_configuration: ?DataSourceVpcConfiguration = null,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .custom_document_enrichment_configuration = "CustomDocumentEnrichmentConfiguration",
        .description = "Description",
        .id = "Id",
        .index_id = "IndexId",
        .language_code = "LanguageCode",
        .name = "Name",
        .role_arn = "RoleArn",
        .schedule = "Schedule",
        .vpc_configuration = "VpcConfiguration",
    };
};
