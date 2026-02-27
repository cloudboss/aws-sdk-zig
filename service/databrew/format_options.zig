const CsvOptions = @import("csv_options.zig").CsvOptions;
const ExcelOptions = @import("excel_options.zig").ExcelOptions;
const JsonOptions = @import("json_options.zig").JsonOptions;

/// Represents a set of options that define the structure of either
/// comma-separated value (CSV),
/// Excel, or JSON input.
pub const FormatOptions = struct {
    /// Options that define how CSV input is to be interpreted by DataBrew.
    csv: ?CsvOptions,

    /// Options that define how Excel input is to be interpreted by DataBrew.
    excel: ?ExcelOptions,

    /// Options that define how JSON input is to be interpreted by DataBrew.
    json: ?JsonOptions,

    pub const json_field_names = .{
        .csv = "Csv",
        .excel = "Excel",
        .json = "Json",
    };
};
