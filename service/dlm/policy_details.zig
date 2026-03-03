const Action = @import("action.zig").Action;
const CrossRegionCopyTarget = @import("cross_region_copy_target.zig").CrossRegionCopyTarget;
const EventSource = @import("event_source.zig").EventSource;
const Exclusions = @import("exclusions.zig").Exclusions;
const Parameters = @import("parameters.zig").Parameters;
const PolicyLanguageValues = @import("policy_language_values.zig").PolicyLanguageValues;
const PolicyTypeValues = @import("policy_type_values.zig").PolicyTypeValues;
const ResourceLocationValues = @import("resource_location_values.zig").ResourceLocationValues;
const ResourceTypeValues = @import("resource_type_values.zig").ResourceTypeValues;
const Schedule = @import("schedule.zig").Schedule;
const Tag = @import("tag.zig").Tag;

/// Specifies the configuration of a lifecycle policy.
pub const PolicyDetails = struct {
    /// **[Event-based policies only]** The actions to be performed when the
    /// event-based policy is activated. You can specify
    /// only one action per policy.
    actions: ?[]const Action = null,

    /// **[Default policies only]** Indicates whether the policy should copy tags
    /// from the source resource
    /// to the snapshot or AMI. If you do not specify a value, the default is
    /// `false`.
    ///
    /// Default: false
    copy_tags: ?bool = null,

    /// **[Default policies only]** Specifies how often the policy should run and
    /// create snapshots or AMIs.
    /// The creation frequency can range from 1 to 7 days. If you do not specify a
    /// value, the
    /// default is 1.
    ///
    /// Default: 1
    create_interval: ?i32 = null,

    /// **[Default policies only]** Specifies destination Regions for snapshot or
    /// AMI copies. You can specify
    /// up to 3 destination Regions. If you do not want to create cross-Region
    /// copies, omit this
    /// parameter.
    cross_region_copy_targets: ?[]const CrossRegionCopyTarget = null,

    /// **[Event-based policies only]** The event that activates the event-based
    /// policy.
    event_source: ?EventSource = null,

    /// **[Default policies only]** Specifies exclusion parameters for volumes or
    /// instances for which you
    /// do not want to create snapshots or AMIs. The policy will not create
    /// snapshots or AMIs
    /// for target resources that match any of the specified exclusion parameters.
    exclusions: ?Exclusions = null,

    /// **[Default policies only]** Defines the snapshot or AMI retention behavior
    /// for the policy if the
    /// source volume or instance is deleted, or if the policy enters the error,
    /// disabled, or
    /// deleted state.
    ///
    /// By default (**ExtendDeletion=false**):
    ///
    /// * If a source resource is deleted, Amazon Data Lifecycle Manager will
    ///   continue to delete previously
    /// created snapshots or AMIs, up to but not including the last one, based on
    /// the
    /// specified retention period. If you want Amazon Data Lifecycle Manager to
    /// delete all snapshots or AMIs,
    /// including the last one, specify `true`.
    ///
    /// * If a policy enters the error, disabled, or deleted state, Amazon Data
    ///   Lifecycle Manager stops deleting
    /// snapshots and AMIs. If you want Amazon Data Lifecycle Manager to continue
    /// deleting snapshots or AMIs,
    /// including the last one, if the policy enters one of these states, specify
    /// `true`.
    ///
    /// If you enable extended deletion (**ExtendDeletion=true**),
    /// you override both default behaviors simultaneously.
    ///
    /// If you do not specify a value, the default is `false`.
    ///
    /// Default: false
    extend_deletion: ?bool = null,

    /// **[Custom snapshot and AMI policies only]** A set of optional parameters for
    /// snapshot and AMI lifecycle policies.
    ///
    /// If you are modifying a policy that was created or previously modified using
    /// the Amazon
    /// Data Lifecycle Manager console, then you must include this parameter and
    /// specify either
    /// the default values or the new values that you require. You can't omit this
    /// parameter or
    /// set its values to null.
    parameters: ?Parameters = null,

    /// The type of policy to create. Specify one of the following:
    ///
    /// * `SIMPLIFIED` To create a default policy.
    ///
    /// * `STANDARD` To create a custom policy.
    policy_language: ?PolicyLanguageValues = null,

    /// The type of policy. Specify `EBS_SNAPSHOT_MANAGEMENT`
    /// to create a lifecycle policy that manages the lifecycle of Amazon EBS
    /// snapshots. Specify `IMAGE_MANAGEMENT`
    /// to create a lifecycle policy that manages the lifecycle of EBS-backed AMIs.
    /// Specify `EVENT_BASED_POLICY `
    /// to create an event-based policy that performs specific actions when a
    /// defined event occurs in your Amazon Web Services account.
    ///
    /// The default is `EBS_SNAPSHOT_MANAGEMENT`.
    policy_type: ?PolicyTypeValues = null,

    /// **[Custom snapshot and AMI policies only]** The location of the resources to
    /// backup.
    ///
    /// * If the source resources are located in a Region, specify `CLOUD`. In this
    ///   case,
    /// the policy targets all resources of the specified type with matching target
    /// tags across all
    /// Availability Zones in the Region.
    ///
    /// * **[Custom snapshot policies only]** If the source resources are located in
    ///   a Local Zone, specify `LOCAL_ZONE`.
    /// In this case, the policy targets all resources of the specified type with
    /// matching target
    /// tags across all Local Zones in the Region.
    ///
    /// * If the source resources are located on an Outpost in your account, specify
    ///   `OUTPOST`.
    /// In this case, the policy targets all resources of the specified type with
    /// matching target
    /// tags across all of the Outposts in your account.
    resource_locations: ?[]const ResourceLocationValues = null,

    /// **[Default policies only]** Specify the type of default policy to create.
    ///
    /// * To create a default policy for EBS snapshots, that creates snapshots of
    ///   all volumes in the
    /// Region that do not have recent backups, specify `VOLUME`.
    ///
    /// * To create a default policy for EBS-backed AMIs, that creates EBS-backed
    /// AMIs from all instances in the Region that do not have recent backups,
    /// specify
    /// `INSTANCE`.
    resource_type: ?ResourceTypeValues = null,

    /// **[Custom snapshot policies only]** The target resource type for snapshot
    /// and AMI lifecycle policies. Use `VOLUME `to
    /// create snapshots of individual volumes or use `INSTANCE` to create
    /// multi-volume
    /// snapshots from the volumes for an instance.
    resource_types: ?[]const ResourceTypeValues = null,

    /// **[Default policies only]** Specifies how long the policy should retain
    /// snapshots or AMIs before
    /// deleting them. The retention period can range from 2 to 14 days, but it must
    /// be greater
    /// than the creation frequency to ensure that the policy retains at least 1
    /// snapshot or
    /// AMI at any given time. If you do not specify a value, the default is 7.
    ///
    /// Default: 7
    retain_interval: ?i32 = null,

    /// **[Custom snapshot and AMI policies only]** The schedules of policy-defined
    /// actions for snapshot and AMI lifecycle policies. A policy
    /// can have up to four schedules—one mandatory schedule and up to three
    /// optional schedules.
    schedules: ?[]const Schedule = null,

    /// **[Custom snapshot and AMI policies only]** The single tag that identifies
    /// targeted resources for this policy.
    target_tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .actions = "Actions",
        .copy_tags = "CopyTags",
        .create_interval = "CreateInterval",
        .cross_region_copy_targets = "CrossRegionCopyTargets",
        .event_source = "EventSource",
        .exclusions = "Exclusions",
        .extend_deletion = "ExtendDeletion",
        .parameters = "Parameters",
        .policy_language = "PolicyLanguage",
        .policy_type = "PolicyType",
        .resource_locations = "ResourceLocations",
        .resource_type = "ResourceType",
        .resource_types = "ResourceTypes",
        .retain_interval = "RetainInterval",
        .schedules = "Schedules",
        .target_tags = "TargetTags",
    };
};
