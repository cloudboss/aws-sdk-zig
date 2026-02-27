const AmplitudeMetadata = @import("amplitude_metadata.zig").AmplitudeMetadata;
const CustomerProfilesMetadata = @import("customer_profiles_metadata.zig").CustomerProfilesMetadata;
const DatadogMetadata = @import("datadog_metadata.zig").DatadogMetadata;
const DynatraceMetadata = @import("dynatrace_metadata.zig").DynatraceMetadata;
const EventBridgeMetadata = @import("event_bridge_metadata.zig").EventBridgeMetadata;
const GoogleAnalyticsMetadata = @import("google_analytics_metadata.zig").GoogleAnalyticsMetadata;
const HoneycodeMetadata = @import("honeycode_metadata.zig").HoneycodeMetadata;
const InforNexusMetadata = @import("infor_nexus_metadata.zig").InforNexusMetadata;
const MarketoMetadata = @import("marketo_metadata.zig").MarketoMetadata;
const PardotMetadata = @import("pardot_metadata.zig").PardotMetadata;
const RedshiftMetadata = @import("redshift_metadata.zig").RedshiftMetadata;
const S3Metadata = @import("s3_metadata.zig").S3Metadata;
const SalesforceMetadata = @import("salesforce_metadata.zig").SalesforceMetadata;
const SAPODataMetadata = @import("sapo_data_metadata.zig").SAPODataMetadata;
const ServiceNowMetadata = @import("service_now_metadata.zig").ServiceNowMetadata;
const SingularMetadata = @import("singular_metadata.zig").SingularMetadata;
const SlackMetadata = @import("slack_metadata.zig").SlackMetadata;
const SnowflakeMetadata = @import("snowflake_metadata.zig").SnowflakeMetadata;
const TrendmicroMetadata = @import("trendmicro_metadata.zig").TrendmicroMetadata;
const UpsolverMetadata = @import("upsolver_metadata.zig").UpsolverMetadata;
const VeevaMetadata = @import("veeva_metadata.zig").VeevaMetadata;
const ZendeskMetadata = @import("zendesk_metadata.zig").ZendeskMetadata;

/// A structure to specify connector-specific metadata such as `oAuthScopes`,
/// `supportedRegions`, `privateLinkServiceUrl`, and so on.
pub const ConnectorMetadata = struct {
    /// The connector metadata specific to Amplitude.
    amplitude: ?AmplitudeMetadata,

    /// The connector metadata specific to Amazon Connect Customer Profiles.
    customer_profiles: ?CustomerProfilesMetadata,

    /// The connector metadata specific to Datadog.
    datadog: ?DatadogMetadata,

    /// The connector metadata specific to Dynatrace.
    dynatrace: ?DynatraceMetadata,

    /// The connector metadata specific to Amazon EventBridge.
    event_bridge: ?EventBridgeMetadata,

    /// The connector metadata specific to Google Analytics.
    google_analytics: ?GoogleAnalyticsMetadata,

    /// The connector metadata specific to Amazon Honeycode.
    honeycode: ?HoneycodeMetadata,

    /// The connector metadata specific to Infor Nexus.
    infor_nexus: ?InforNexusMetadata,

    /// The connector metadata specific to Marketo.
    marketo: ?MarketoMetadata,

    /// The connector metadata specific to Salesforce Pardot.
    pardot: ?PardotMetadata,

    /// The connector metadata specific to Amazon Redshift.
    redshift: ?RedshiftMetadata,

    /// The connector metadata specific to Amazon S3.
    s3: ?S3Metadata,

    /// The connector metadata specific to Salesforce.
    salesforce: ?SalesforceMetadata,

    sapo_data: ?SAPODataMetadata,

    /// The connector metadata specific to ServiceNow.
    service_now: ?ServiceNowMetadata,

    /// The connector metadata specific to Singular.
    singular: ?SingularMetadata,

    /// The connector metadata specific to Slack.
    slack: ?SlackMetadata,

    /// The connector metadata specific to Snowflake.
    snowflake: ?SnowflakeMetadata,

    /// The connector metadata specific to Trend Micro.
    trendmicro: ?TrendmicroMetadata,

    /// The connector metadata specific to Upsolver.
    upsolver: ?UpsolverMetadata,

    /// The connector metadata specific to Veeva.
    veeva: ?VeevaMetadata,

    /// The connector metadata specific to Zendesk.
    zendesk: ?ZendeskMetadata,

    pub const json_field_names = .{
        .amplitude = "Amplitude",
        .customer_profiles = "CustomerProfiles",
        .datadog = "Datadog",
        .dynatrace = "Dynatrace",
        .event_bridge = "EventBridge",
        .google_analytics = "GoogleAnalytics",
        .honeycode = "Honeycode",
        .infor_nexus = "InforNexus",
        .marketo = "Marketo",
        .pardot = "Pardot",
        .redshift = "Redshift",
        .s3 = "S3",
        .salesforce = "Salesforce",
        .sapo_data = "SAPOData",
        .service_now = "ServiceNow",
        .singular = "Singular",
        .slack = "Slack",
        .snowflake = "Snowflake",
        .trendmicro = "Trendmicro",
        .upsolver = "Upsolver",
        .veeva = "Veeva",
        .zendesk = "Zendesk",
    };
};
