const IndexField = @import("index_field.zig").IndexField;
const OptionStatus = @import("option_status.zig").OptionStatus;

/// The value of an `IndexField` and its current status.
pub const IndexFieldStatus = struct {
    options: IndexField,

    status: OptionStatus,
};
