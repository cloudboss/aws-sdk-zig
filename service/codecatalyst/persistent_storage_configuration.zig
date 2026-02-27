/// Information about the configuration of persistent storage for a Dev
/// Environment.
pub const PersistentStorageConfiguration = struct {
    /// The size of the persistent storage in gigabytes (specifically GiB).
    ///
    /// Valid values for storage are based on memory sizes in 16GB increments. Valid
    /// values are
    /// 16, 32, and 64.
    size_in_gi_b: i32,

    pub const json_field_names = .{
        .size_in_gi_b = "sizeInGiB",
    };
};
