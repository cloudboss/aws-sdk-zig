const AmplitudeSourceProperties = @import("amplitude_source_properties.zig").AmplitudeSourceProperties;
const CustomConnectorSourceProperties = @import("custom_connector_source_properties.zig").CustomConnectorSourceProperties;
const DatadogSourceProperties = @import("datadog_source_properties.zig").DatadogSourceProperties;
const DynatraceSourceProperties = @import("dynatrace_source_properties.zig").DynatraceSourceProperties;
const GoogleAnalyticsSourceProperties = @import("google_analytics_source_properties.zig").GoogleAnalyticsSourceProperties;
const InforNexusSourceProperties = @import("infor_nexus_source_properties.zig").InforNexusSourceProperties;
const MarketoSourceProperties = @import("marketo_source_properties.zig").MarketoSourceProperties;
const PardotSourceProperties = @import("pardot_source_properties.zig").PardotSourceProperties;
const S3SourceProperties = @import("s3_source_properties.zig").S3SourceProperties;
const SalesforceSourceProperties = @import("salesforce_source_properties.zig").SalesforceSourceProperties;
const SAPODataSourceProperties = @import("sapo_data_source_properties.zig").SAPODataSourceProperties;
const ServiceNowSourceProperties = @import("service_now_source_properties.zig").ServiceNowSourceProperties;
const SingularSourceProperties = @import("singular_source_properties.zig").SingularSourceProperties;
const SlackSourceProperties = @import("slack_source_properties.zig").SlackSourceProperties;
const TrendmicroSourceProperties = @import("trendmicro_source_properties.zig").TrendmicroSourceProperties;
const VeevaSourceProperties = @import("veeva_source_properties.zig").VeevaSourceProperties;
const ZendeskSourceProperties = @import("zendesk_source_properties.zig").ZendeskSourceProperties;

/// Specifies the information that is required to query a particular connector.
pub const SourceConnectorProperties = struct {
    /// Specifies the information that is required for querying Amplitude.
    amplitude: ?AmplitudeSourceProperties = null,

    custom_connector: ?CustomConnectorSourceProperties = null,

    /// Specifies the information that is required for querying Datadog.
    datadog: ?DatadogSourceProperties = null,

    /// Specifies the information that is required for querying Dynatrace.
    dynatrace: ?DynatraceSourceProperties = null,

    /// Specifies the information that is required for querying Google Analytics.
    google_analytics: ?GoogleAnalyticsSourceProperties = null,

    /// Specifies the information that is required for querying Infor Nexus.
    infor_nexus: ?InforNexusSourceProperties = null,

    /// Specifies the information that is required for querying Marketo.
    marketo: ?MarketoSourceProperties = null,

    /// Specifies the information that is required for querying Salesforce Pardot.
    pardot: ?PardotSourceProperties = null,

    /// Specifies the information that is required for querying Amazon S3.
    s3: ?S3SourceProperties = null,

    /// Specifies the information that is required for querying Salesforce.
    salesforce: ?SalesforceSourceProperties = null,

    sapo_data: ?SAPODataSourceProperties = null,

    /// Specifies the information that is required for querying ServiceNow.
    service_now: ?ServiceNowSourceProperties = null,

    /// Specifies the information that is required for querying Singular.
    singular: ?SingularSourceProperties = null,

    /// Specifies the information that is required for querying Slack.
    slack: ?SlackSourceProperties = null,

    /// Specifies the information that is required for querying Trend Micro.
    trendmicro: ?TrendmicroSourceProperties = null,

    /// Specifies the information that is required for querying Veeva.
    veeva: ?VeevaSourceProperties = null,

    /// Specifies the information that is required for querying Zendesk.
    zendesk: ?ZendeskSourceProperties = null,

    pub const json_field_names = .{
        .amplitude = "Amplitude",
        .custom_connector = "CustomConnector",
        .datadog = "Datadog",
        .dynatrace = "Dynatrace",
        .google_analytics = "GoogleAnalytics",
        .infor_nexus = "InforNexus",
        .marketo = "Marketo",
        .pardot = "Pardot",
        .s3 = "S3",
        .salesforce = "Salesforce",
        .sapo_data = "SAPOData",
        .service_now = "ServiceNow",
        .singular = "Singular",
        .slack = "Slack",
        .trendmicro = "Trendmicro",
        .veeva = "Veeva",
        .zendesk = "Zendesk",
    };
};
