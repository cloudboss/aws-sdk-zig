/// Specifies a transform that writes samples of the data to an Amazon S3
/// bucket.
pub const Spigot = struct {
    /// The data inputs identified by their node names.
    inputs: []const []const u8,

    /// The name of the transform node.
    name: []const u8,

    /// A path in Amazon S3 where the transform will write a subset of records from
    /// the dataset to a JSON file in an Amazon S3 bucket.
    path: []const u8,

    /// The probability (a decimal value with a maximum value of 1) of picking any
    /// given record. A value of 1 indicates that each row read from the dataset
    /// should be included in the sample output.
    prob: ?f64 = null,

    /// Specifies a number of records to write starting from the beginning of the
    /// dataset.
    topk: ?i32 = null,

    pub const json_field_names = .{
        .inputs = "Inputs",
        .name = "Name",
        .path = "Path",
        .prob = "Prob",
        .topk = "Topk",
    };
};
