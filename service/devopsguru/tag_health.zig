const InsightHealth = @import("insight_health.zig").InsightHealth;

/// Information about the health of Amazon Web Services resources in your
/// account that are specified by
/// an Amazon Web Services tag *key*.
pub const TagHealth = struct {
    /// Number of resources that DevOps Guru is monitoring in your account that are
    /// specified by an Amazon Web Services tag.
    analyzed_resource_count: ?i64,

    /// An Amazon Web Services tag *key* that is used to identify the Amazon Web
    /// Services resources that
    /// DevOps Guru analyzes. All Amazon Web Services resources in your account and
    /// Region tagged with this *key* make
    /// up your DevOps Guru application and analysis boundary.
    ///
    /// The string used for a *key* in a tag that you use to define your resource
    /// coverage must begin with the
    /// prefix `Devops-guru-`. The tag *key* might be
    /// `DevOps-Guru-deployment-application` or
    /// `devops-guru-rds-application`. When you create a *key*, the case of
    /// characters in the *key* can be whatever you choose. After you create a
    /// *key*, it is case-sensitive.
    /// For example, DevOps Guru works with a
    /// *key* named `devops-guru-rds` and a *key* named
    /// `DevOps-Guru-RDS`, and these act as two different *keys*. Possible
    /// *key*/*value* pairs in your
    /// application might be `Devops-Guru-production-application/RDS` or
    /// `Devops-Guru-production-application/containers`.
    app_boundary_key: ?[]const u8,

    /// Information about the health of the Amazon Web Services resources in your
    /// account that are specified
    /// by an Amazon Web Services tag, including the number of open proactive, open
    /// reactive insights, and the
    /// Mean Time to Recover (MTTR) of closed insights.
    insight: ?InsightHealth,

    /// The value in an Amazon Web Services tag.
    ///
    /// The tag's *value* is an optional field used to associate a string with
    /// the tag *key* (for example, `111122223333`, `Production`, or a team
    /// name). The *key* and *value* are the tag's *key* pair.
    /// Omitting the tag *value* is the same as using an empty
    /// string. Like tag *keys*, tag *values* are
    /// case-sensitive. You can specify a maximum of 256 characters for a tag value.
    tag_value: ?[]const u8,

    pub const json_field_names = .{
        .analyzed_resource_count = "AnalyzedResourceCount",
        .app_boundary_key = "AppBoundaryKey",
        .insight = "Insight",
        .tag_value = "TagValue",
    };
};
