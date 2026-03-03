const WriteOperationType = @import("write_operation_type.zig").WriteOperationType;

/// The properties that can be applied to a field when connector is being used
/// as a
/// destination.
pub const DestinationFieldProperties = struct {
    /// Specifies if the destination field can be created by the current user.
    is_creatable: bool = false,

    /// Specifies whether the field can use the default value during a Create
    /// operation.
    is_defaulted_on_create: bool = false,

    /// Specifies if the destination field can have a null value.
    is_nullable: bool = false,

    /// Specifies whether the field can be updated during an `UPDATE` or
    /// `UPSERT` write operation.
    is_updatable: bool = false,

    /// Specifies if the flow run can either insert new rows in the destination
    /// field if they do
    /// not already exist, or update them if they do.
    is_upsertable: bool = false,

    /// A list of supported write operations. For each write operation listed, this
    /// field can be
    /// used in `idFieldNames` when that write operation is present as a destination
    /// option.
    supported_write_operations: ?[]const WriteOperationType = null,

    pub const json_field_names = .{
        .is_creatable = "isCreatable",
        .is_defaulted_on_create = "isDefaultedOnCreate",
        .is_nullable = "isNullable",
        .is_updatable = "isUpdatable",
        .is_upsertable = "isUpsertable",
        .supported_write_operations = "supportedWriteOperations",
    };
};
