const ProcessingInstanceType = @import("processing_instance_type.zig").ProcessingInstanceType;

/// A candidate instance type preference in a processing `InstancePreferences`
/// list.
pub const ProcessingInstancePreference = struct {
    /// The number of instances to launch if this instance type is selected. Specify
    /// the instance count for the processing job in one of the following two ways:
    ///
    /// * **Per preference** – Set `InstanceCount` on every preference in the
    ///   `InstancePreferences` list and don't set
    ///   `ProcessingClusterConfig$InstanceCount`. Use this when each instance type
    ///   needs a different number of instances to deliver equivalent compute.
    /// * **One count for the job** – Set `ProcessingClusterConfig$InstanceCount`
    ///   and omit it from every preference. Amazon SageMaker applies this to all
    ///   instance types in the list.
    ///
    /// For example, in a list of five preferences, either all five specify
    /// `InstanceCount` or none of them do. Amazon SageMaker rejects requests that
    /// set `InstanceCount` on only some preferences, that set it both per
    /// preference and in `ProcessingClusterConfig`, or that omit it in both places.
    instance_count: ?i32 = null,

    /// The ML compute instance type. An instance type can appear only once in an
    /// `InstancePreferences` list.
    instance_type: ProcessingInstanceType,

    pub const json_field_names = .{
        .instance_count = "InstanceCount",
        .instance_type = "InstanceType",
    };
};
