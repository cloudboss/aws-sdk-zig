const TransitionToArchiveRules = @import("transition_to_archive_rules.zig").TransitionToArchiveRules;
const TransitionToIARules = @import("transition_to_ia_rules.zig").TransitionToIARules;
const TransitionToPrimaryStorageClassRules = @import("transition_to_primary_storage_class_rules.zig").TransitionToPrimaryStorageClassRules;

/// Describes a policy used by lifecycle management that specifies when to
/// transition files
/// into and out of storage classes. For more information, see [Managing file
/// system
/// storage](https://docs.aws.amazon.com/efs/latest/ug/lifecycle-management-efs.html).
///
/// When using the `put-lifecycle-configuration` CLI command or the
/// `PutLifecycleConfiguration` API action, Amazon EFS requires that each
/// `LifecyclePolicy` object have only a single transition. This means that in a
/// request body, `LifecyclePolicies` must be structured as an array of
/// `LifecyclePolicy` objects, one object for each transition. For more
/// information, see the request examples in PutLifecycleConfiguration.
pub const LifecyclePolicy = struct {
    /// The number of days after files were last accessed in primary storage (the
    /// Standard storage class) at which to move them to Archive
    /// storage. Metadata operations such as listing the contents of a directory
    /// don't count as
    /// file access events.
    transition_to_archive: ?TransitionToArchiveRules = null,

    /// The number of days after files were last accessed in primary storage (the
    /// Standard storage class) at which to move them to Infrequent Access
    /// (IA) storage. Metadata operations such as listing the contents of a
    /// directory
    /// don't count as file access events.
    transition_to_ia: ?TransitionToIARules = null,

    /// Whether to move files back to primary (Standard) storage after they are
    /// accessed in IA or Archive storage. Metadata operations such as
    /// listing the contents of a directory don't count as file access events.
    transition_to_primary_storage_class: ?TransitionToPrimaryStorageClassRules = null,

    pub const json_field_names = .{
        .transition_to_archive = "TransitionToArchive",
        .transition_to_ia = "TransitionToIA",
        .transition_to_primary_storage_class = "TransitionToPrimaryStorageClass",
    };
};
