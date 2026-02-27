/// The data format of a file, can be one of the following:
///
/// * `CSV` – A comma-separated values file.
///
/// * `JSON` – A JSON file.
pub const DataFormat = enum {
    csv,
    json,

    pub const json_field_names = .{
        .csv = "CSV",
        .json = "JSON",
    };
};
