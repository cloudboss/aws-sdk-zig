const ResourceType = @import("resource_type.zig").ResourceType;

/// Specifies whether the configuration recorder excludes certain resource types
/// from being recorded.
/// Use the `resourceTypes` field to enter a comma-separated list of resource
/// types you want to exclude from recording.
///
/// By default, when Config adds support for a new resource type in the Region
/// where you set up the configuration recorder,
/// including global resource types, Config starts recording resources of that
/// type automatically.
///
/// **How to use the exclusion recording strategy **
///
/// To use this option, you must set the `useOnly`
/// field of
/// [RecordingStrategy](https://docs.aws.amazon.com/config/latest/APIReference/API_RecordingStrategy.html)
/// to `EXCLUSION_BY_RESOURCE_TYPES`.
///
/// Config will then record configuration changes for all supported resource
/// types, except the resource types that you specify to exclude from being
/// recorded.
///
/// **Global resource types and the exclusion recording strategy **
///
/// Unless specifically listed as exclusions,
/// `AWS::RDS::GlobalCluster` will be recorded automatically in all supported
/// Config Regions were the configuration recorder is enabled.
///
/// IAM users, groups, roles, and customer managed policies will be recorded in
/// the Region where you set up the configuration recorder if that is a Region
/// where Config was available before February 2022.
/// You cannot be record the global IAM resouce types in Regions supported by
/// Config after February 2022. For a list of those Regions,
/// see [Recording Amazon Web Services Resources | Global
/// Resources](https://docs.aws.amazon.com/config/latest/developerguide/select-resources.html#select-resources-all).
pub const ExclusionByResourceTypes = struct {
    /// A comma-separated list of resource types to exclude from recording by the
    /// configuration
    /// recorder.
    resource_types: ?[]const ResourceType,

    pub const json_field_names = .{
        .resource_types = "resourceTypes",
    };
};
