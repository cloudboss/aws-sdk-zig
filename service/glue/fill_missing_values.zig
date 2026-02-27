/// Specifies a transform that locates records in the dataset that have missing
/// values and adds a new field with a value determined by imputation. The input
/// data set is used to train the machine learning model that determines what
/// the missing value should be.
pub const FillMissingValues = struct {
    /// A JSON path to a variable in the data structure for the dataset that is
    /// filled.
    filled_path: ?[]const u8,

    /// A JSON path to a variable in the data structure for the dataset that is
    /// imputed.
    imputed_path: []const u8,

    /// The data inputs identified by their node names.
    inputs: []const []const u8,

    /// The name of the transform node.
    name: []const u8,

    pub const json_field_names = .{
        .filled_path = "FilledPath",
        .imputed_path = "ImputedPath",
        .inputs = "Inputs",
        .name = "Name",
    };
};
