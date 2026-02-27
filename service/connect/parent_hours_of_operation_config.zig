/// Contains configuration for the parent hours of operation.
pub const ParentHoursOfOperationConfig = struct {
    /// The identifier for the hours of operation.
    hours_of_operation_id: ?[]const u8,

    pub const json_field_names = .{
        .hours_of_operation_id = "HoursOfOperationId",
    };
};
