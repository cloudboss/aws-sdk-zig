const ComputeModel = @import("compute_model.zig").ComputeModel;
const ShapeType = @import("shape_type.zig").ShapeType;

/// Information about a hardware system model (shape) that's available for an
/// Exadata infrastructure. The shape determines resources, such as CPU cores,
/// memory, and storage, to allocate to the Exadata infrastructure.
pub const DbSystemShapeSummary = struct {
    /// Indicates whether the hardware system model supports configurable database
    /// and server storage types.
    are_server_types_supported: ?bool,

    /// The maximum number of CPU cores that can be enabled for the shape.
    available_core_count: ?i32,

    /// The maximum number of CPU cores per DB node that can be enabled for the
    /// shape.
    available_core_count_per_node: ?i32,

    /// The maximum amount of data storage, in terabytes (TB), that can be enabled
    /// for the shape.
    available_data_storage_in_t_bs: ?i32,

    /// The maximum amount of data storage, in terabytes (TB), that's available per
    /// storage server for the shape.
    available_data_storage_per_server_in_t_bs: ?i32,

    /// The maximum amount of DB node storage, in gigabytes (GB), that's available
    /// per DB node for the shape.
    available_db_node_per_node_in_g_bs: ?i32,

    /// The maximum amount of DB node storage, in gigabytes (GB), that can be
    /// enabled for the shape.
    available_db_node_storage_in_g_bs: ?i32,

    /// The maximum amount of memory, in gigabytes (GB), that can be enabled for the
    /// shape.
    available_memory_in_g_bs: ?i32,

    /// The maximum amount of memory, in gigabytes (GB), that's available per DB
    /// node for the shape.
    available_memory_per_node_in_g_bs: ?i32,

    /// The OCI model compute model used when you create or clone an instance: ECPU
    /// or OCPU. An ECPU is an abstracted measure of compute resources. ECPUs are
    /// based on the number of cores elastically allocated from a pool of compute
    /// and storage servers. An OCPU is a legacy physical measure of compute
    /// resources. OCPUs are based on the physical core of a processor with
    /// hyper-threading enabled.
    compute_model: ?ComputeModel,

    /// The discrete number by which the CPU core count for the shape can be
    /// increased or decreased.
    core_count_increment: ?i32,

    /// The maximum number of compute servers that is available for the shape.
    maximum_node_count: ?i32,

    /// The maximum number of Exadata storage servers that's available for the
    /// shape.
    max_storage_count: ?i32,

    /// The minimum number of CPU cores that can be enabled per node for the shape.
    min_core_count_per_node: ?i32,

    /// The minimum amount of data storage, in terabytes (TB), that must be
    /// allocated for the shape.
    min_data_storage_in_t_bs: ?i32,

    /// The minimum amount of DB node storage, in gigabytes (GB), that must be
    /// allocated per DB node for the shape.
    min_db_node_storage_per_node_in_g_bs: ?i32,

    /// The minimum number of CPU cores that can be enabled for the shape.
    minimum_core_count: ?i32,

    /// The minimum number of compute servers that are available for the shape.
    minimum_node_count: ?i32,

    /// The minimum amount of memory, in gigabytes (GB), that must be allocated per
    /// DB node for the shape.
    min_memory_per_node_in_g_bs: ?i32,

    /// The minimum number of Exadata storage servers that are available for the
    /// shape.
    min_storage_count: ?i32,

    /// The name of the shape.
    name: ?[]const u8,

    /// The runtime minimum number of CPU cores that can be enabled for the shape.
    runtime_minimum_core_count: ?i32,

    /// The family of the shape.
    shape_family: ?[]const u8,

    /// The shape type. This property is determined by the CPU hardware.
    shape_type: ?ShapeType,

    pub const json_field_names = .{
        .are_server_types_supported = "areServerTypesSupported",
        .available_core_count = "availableCoreCount",
        .available_core_count_per_node = "availableCoreCountPerNode",
        .available_data_storage_in_t_bs = "availableDataStorageInTBs",
        .available_data_storage_per_server_in_t_bs = "availableDataStoragePerServerInTBs",
        .available_db_node_per_node_in_g_bs = "availableDbNodePerNodeInGBs",
        .available_db_node_storage_in_g_bs = "availableDbNodeStorageInGBs",
        .available_memory_in_g_bs = "availableMemoryInGBs",
        .available_memory_per_node_in_g_bs = "availableMemoryPerNodeInGBs",
        .compute_model = "computeModel",
        .core_count_increment = "coreCountIncrement",
        .maximum_node_count = "maximumNodeCount",
        .max_storage_count = "maxStorageCount",
        .min_core_count_per_node = "minCoreCountPerNode",
        .min_data_storage_in_t_bs = "minDataStorageInTBs",
        .min_db_node_storage_per_node_in_g_bs = "minDbNodeStoragePerNodeInGBs",
        .minimum_core_count = "minimumCoreCount",
        .minimum_node_count = "minimumNodeCount",
        .min_memory_per_node_in_g_bs = "minMemoryPerNodeInGBs",
        .min_storage_count = "minStorageCount",
        .name = "name",
        .runtime_minimum_core_count = "runtimeMinimumCoreCount",
        .shape_family = "shapeFamily",
        .shape_type = "shapeType",
    };
};
