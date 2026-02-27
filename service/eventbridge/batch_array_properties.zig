/// The array properties for the submitted job, such as the size of the array.
/// The array size
/// can be between 2 and 10,000. If you specify array properties for a job, it
/// becomes an array
/// job. This parameter is used only if the target is an Batch job.
pub const BatchArrayProperties = struct {
    /// The size of the array, if this is an array batch job. Valid values are
    /// integers between 2
    /// and 10,000.
    size: i32 = 0,

    pub const json_field_names = .{
        .size = "Size",
    };
};
