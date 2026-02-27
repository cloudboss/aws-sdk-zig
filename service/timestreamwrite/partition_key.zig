const PartitionKeyEnforcementLevel = @import("partition_key_enforcement_level.zig").PartitionKeyEnforcementLevel;
const PartitionKeyType = @import("partition_key_type.zig").PartitionKeyType;

/// An attribute used in partitioning data in a table. A dimension key
/// partitions data
/// using the values of the dimension specified by the dimension-name as
/// partition key, while a
/// measure key partitions data using measure names (values of the
/// 'measure_name' column).
pub const PartitionKey = struct {
    /// The level of enforcement for the specification of a dimension key in
    /// ingested records.
    /// Options are REQUIRED (dimension key must be specified) and OPTIONAL
    /// (dimension key does not
    /// have to be specified).
    enforcement_in_record: ?PartitionKeyEnforcementLevel,

    /// The name of the attribute used for a dimension key.
    name: ?[]const u8,

    /// The type of the partition key. Options are DIMENSION (dimension key) and
    /// MEASURE
    /// (measure key).
    type: PartitionKeyType,

    pub const json_field_names = .{
        .enforcement_in_record = "EnforcementInRecord",
        .name = "Name",
        .type = "Type",
    };
};
