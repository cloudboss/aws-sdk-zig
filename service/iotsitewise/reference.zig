const DataSetReference = @import("data_set_reference.zig").DataSetReference;

/// Contains the reference information.
pub const Reference = struct {
    /// Contains the dataset reference information.
    dataset: ?DataSetReference = null,

    pub const json_field_names = .{
        .dataset = "dataset",
    };
};
