/// The estimated size of the resource.
pub const EstimatedResourceSize = struct {
    /// The time when the estimate of the size of the resource was made.
    estimated_on: ?i64,

    /// The estimated size of the resource, in bytes.
    estimated_size_in_bytes: ?f64,

    pub const json_field_names = .{
        .estimated_on = "estimatedOn",
        .estimated_size_in_bytes = "estimatedSizeInBytes",
    };
};
