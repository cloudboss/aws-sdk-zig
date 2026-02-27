const AmplitudeConnectorProfileProperties = @import("amplitude_connector_profile_properties.zig").AmplitudeConnectorProfileProperties;
const CustomConnectorProfileProperties = @import("custom_connector_profile_properties.zig").CustomConnectorProfileProperties;
const DatadogConnectorProfileProperties = @import("datadog_connector_profile_properties.zig").DatadogConnectorProfileProperties;
const DynatraceConnectorProfileProperties = @import("dynatrace_connector_profile_properties.zig").DynatraceConnectorProfileProperties;
const GoogleAnalyticsConnectorProfileProperties = @import("google_analytics_connector_profile_properties.zig").GoogleAnalyticsConnectorProfileProperties;
const HoneycodeConnectorProfileProperties = @import("honeycode_connector_profile_properties.zig").HoneycodeConnectorProfileProperties;
const InforNexusConnectorProfileProperties = @import("infor_nexus_connector_profile_properties.zig").InforNexusConnectorProfileProperties;
const MarketoConnectorProfileProperties = @import("marketo_connector_profile_properties.zig").MarketoConnectorProfileProperties;
const PardotConnectorProfileProperties = @import("pardot_connector_profile_properties.zig").PardotConnectorProfileProperties;
const RedshiftConnectorProfileProperties = @import("redshift_connector_profile_properties.zig").RedshiftConnectorProfileProperties;
const SalesforceConnectorProfileProperties = @import("salesforce_connector_profile_properties.zig").SalesforceConnectorProfileProperties;
const SAPODataConnectorProfileProperties = @import("sapo_data_connector_profile_properties.zig").SAPODataConnectorProfileProperties;
const ServiceNowConnectorProfileProperties = @import("service_now_connector_profile_properties.zig").ServiceNowConnectorProfileProperties;
const SingularConnectorProfileProperties = @import("singular_connector_profile_properties.zig").SingularConnectorProfileProperties;
const SlackConnectorProfileProperties = @import("slack_connector_profile_properties.zig").SlackConnectorProfileProperties;
const SnowflakeConnectorProfileProperties = @import("snowflake_connector_profile_properties.zig").SnowflakeConnectorProfileProperties;
const TrendmicroConnectorProfileProperties = @import("trendmicro_connector_profile_properties.zig").TrendmicroConnectorProfileProperties;
const VeevaConnectorProfileProperties = @import("veeva_connector_profile_properties.zig").VeevaConnectorProfileProperties;
const ZendeskConnectorProfileProperties = @import("zendesk_connector_profile_properties.zig").ZendeskConnectorProfileProperties;

/// The connector-specific profile properties required by each connector.
pub const ConnectorProfileProperties = struct {
    /// The connector-specific properties required by Amplitude.
    amplitude: ?AmplitudeConnectorProfileProperties,

    /// The properties required by the custom connector.
    custom_connector: ?CustomConnectorProfileProperties,

    /// The connector-specific properties required by Datadog.
    datadog: ?DatadogConnectorProfileProperties,

    /// The connector-specific properties required by Dynatrace.
    dynatrace: ?DynatraceConnectorProfileProperties,

    /// The connector-specific properties required Google Analytics.
    google_analytics: ?GoogleAnalyticsConnectorProfileProperties,

    /// The connector-specific properties required by Amazon Honeycode.
    honeycode: ?HoneycodeConnectorProfileProperties,

    /// The connector-specific properties required by Infor Nexus.
    infor_nexus: ?InforNexusConnectorProfileProperties,

    /// The connector-specific properties required by Marketo.
    marketo: ?MarketoConnectorProfileProperties,

    /// The connector-specific properties required by Salesforce Pardot.
    pardot: ?PardotConnectorProfileProperties,

    /// The connector-specific properties required by Amazon Redshift.
    redshift: ?RedshiftConnectorProfileProperties,

    /// The connector-specific properties required by Salesforce.
    salesforce: ?SalesforceConnectorProfileProperties,

    sapo_data: ?SAPODataConnectorProfileProperties,

    /// The connector-specific properties required by serviceNow.
    service_now: ?ServiceNowConnectorProfileProperties,

    /// The connector-specific properties required by Singular.
    singular: ?SingularConnectorProfileProperties,

    /// The connector-specific properties required by Slack.
    slack: ?SlackConnectorProfileProperties,

    /// The connector-specific properties required by Snowflake.
    snowflake: ?SnowflakeConnectorProfileProperties,

    /// The connector-specific properties required by Trend Micro.
    trendmicro: ?TrendmicroConnectorProfileProperties,

    /// The connector-specific properties required by Veeva.
    veeva: ?VeevaConnectorProfileProperties,

    /// The connector-specific properties required by Zendesk.
    zendesk: ?ZendeskConnectorProfileProperties,

    pub const json_field_names = .{
        .amplitude = "Amplitude",
        .custom_connector = "CustomConnector",
        .datadog = "Datadog",
        .dynatrace = "Dynatrace",
        .google_analytics = "GoogleAnalytics",
        .honeycode = "Honeycode",
        .infor_nexus = "InforNexus",
        .marketo = "Marketo",
        .pardot = "Pardot",
        .redshift = "Redshift",
        .salesforce = "Salesforce",
        .sapo_data = "SAPOData",
        .service_now = "ServiceNow",
        .singular = "Singular",
        .slack = "Slack",
        .snowflake = "Snowflake",
        .trendmicro = "Trendmicro",
        .veeva = "Veeva",
        .zendesk = "Zendesk",
    };
};
