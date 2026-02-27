const MarketoSourceProperties = @import("marketo_source_properties.zig").MarketoSourceProperties;
const S3SourceProperties = @import("s3_source_properties.zig").S3SourceProperties;
const SalesforceSourceProperties = @import("salesforce_source_properties.zig").SalesforceSourceProperties;
const ServiceNowSourceProperties = @import("service_now_source_properties.zig").ServiceNowSourceProperties;
const ZendeskSourceProperties = @import("zendesk_source_properties.zig").ZendeskSourceProperties;

/// Specifies the information that is required to query a particular Amazon
/// AppFlow connector.
/// Customer Profiles supports Salesforce, Zendesk, Marketo, ServiceNow and
/// Amazon S3.
pub const SourceConnectorProperties = struct {
    /// The properties that are applied when Marketo is being used as a source.
    marketo: ?MarketoSourceProperties,

    /// The properties that are applied when Amazon S3 is being used as the flow
    /// source.
    s3: ?S3SourceProperties,

    /// The properties that are applied when Salesforce is being used as a source.
    salesforce: ?SalesforceSourceProperties,

    /// The properties that are applied when ServiceNow is being used as a source.
    service_now: ?ServiceNowSourceProperties,

    /// The properties that are applied when using Zendesk as a flow source.
    zendesk: ?ZendeskSourceProperties,

    pub const json_field_names = .{
        .marketo = "Marketo",
        .s3 = "S3",
        .salesforce = "Salesforce",
        .service_now = "ServiceNow",
        .zendesk = "Zendesk",
    };
};
