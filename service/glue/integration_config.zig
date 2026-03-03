const aws = @import("aws");

/// Properties associated with the integration.
pub const IntegrationConfig = struct {
    /// Enables continuous synchronization for on-demand data extractions from SaaS
    /// applications to Amazon Web Services data services like Amazon Redshift
    /// and Amazon S3.
    continuous_sync: ?bool = null,

    /// Specifies the frequency at which CDC (Change Data Capture) pulls or
    /// incremental loads should occur. This parameter provides flexibility to align
    /// the refresh rate with your specific data update patterns, system load
    /// considerations, and performance optimization goals. Time increment can be
    /// set from
    /// 15 minutes to 8640 minutes (six days).
    refresh_interval: ?[]const u8 = null,

    /// A collection of key-value pairs that specify additional properties for the
    /// integration source. These properties provide configuration options that
    /// can be used to customize the behavior of the ODB source during data
    /// integration operations.
    source_properties: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .continuous_sync = "ContinuousSync",
        .refresh_interval = "RefreshInterval",
        .source_properties = "SourceProperties",
    };
};
