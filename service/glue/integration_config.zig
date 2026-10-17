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

    /// An optional custom namespace for the integration's target. Supply this
    /// parameter only when the target is an Amazon S3 Tables table bucket; it is
    /// not accepted for other target types. The integration replicates data into
    /// the namespace you specify, reusing it if it already exists. If you omit this
    /// parameter, the target namespace defaults to `zetl_` followed by the
    /// integration ID, with hyphens converted to underscores.
    ///
    /// The value is immutable after the integration is created; `ModifyIntegration`
    /// rejects changes to it. It must be a valid Amazon S3 Tables namespace name: 1
    /// to 255 characters using lowercase letters, numbers, and underscores, with no
    /// leading or trailing underscore and no reserved `aws` prefix.
    target_namespace: ?[]const u8 = null,

    pub const json_field_names = .{
        .continuous_sync = "ContinuousSync",
        .refresh_interval = "RefreshInterval",
        .source_properties = "SourceProperties",
        .target_namespace = "TargetNamespace",
    };
};
