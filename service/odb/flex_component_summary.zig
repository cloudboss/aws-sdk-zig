const ComputeModel = @import("compute_model.zig").ComputeModel;
const HardwareType = @import("hardware_type.zig").HardwareType;

/// Information about a flex component that's available for an Exadata
/// infrastructure. A flex component defines the hardware resources, such as CPU
/// cores, memory, and storage, that can be allocated to a shape.
pub const FlexComponentSummary = struct {
    /// The maximum number of CPU cores that can be enabled for the flex component.
    available_core_count: ?i32 = null,

    /// The maximum amount of database storage, in gigabytes (GB), that can be
    /// enabled for the flex component.
    available_db_storage_in_g_bs: ?i32 = null,

    /// The maximum amount of local storage, in gigabytes (GB), that can be enabled
    /// for the flex component.
    available_local_storage_in_g_bs: ?i32 = null,

    /// The maximum amount of memory, in gigabytes (GB), that can be enabled for the
    /// flex component.
    available_memory_in_g_bs: ?i32 = null,

    /// The OCI model compute model used when you create or clone an instance: ECPU
    /// or OCPU. An ECPU is an abstracted measure of compute resources. ECPUs are
    /// based on the number of cores elastically allocated from a pool of compute
    /// and storage servers. An OCPU is a legacy physical measure of compute
    /// resources. OCPUs are based on the physical core of a processor with
    /// hyper-threading enabled.
    compute_model: ?ComputeModel = null,

    /// A summary description of the flex component.
    description_summary: ?[]const u8 = null,

    /// The type of hardware for the flex component. Valid values are `COMPUTE` for
    /// compute servers and `CELL` for storage servers.
    hardware_type: ?HardwareType = null,

    /// The minimum number of CPU cores that can be enabled for the flex component.
    minimum_core_count: ?i32 = null,

    /// The name of the flex component.
    name: ?[]const u8 = null,

    /// The runtime minimum number of CPU cores that can be enabled for the flex
    /// component.
    runtime_minimum_core_count: ?i32 = null,

    /// The shape that uses the flex component.
    shape: ?[]const u8 = null,

    pub const json_field_names = .{
        .available_core_count = "availableCoreCount",
        .available_db_storage_in_g_bs = "availableDbStorageInGBs",
        .available_local_storage_in_g_bs = "availableLocalStorageInGBs",
        .available_memory_in_g_bs = "availableMemoryInGBs",
        .compute_model = "computeModel",
        .description_summary = "descriptionSummary",
        .hardware_type = "hardwareType",
        .minimum_core_count = "minimumCoreCount",
        .name = "name",
        .runtime_minimum_core_count = "runtimeMinimumCoreCount",
        .shape = "shape",
    };
};
