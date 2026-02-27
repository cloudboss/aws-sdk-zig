const X12ControlNumbers = @import("x12_control_numbers.zig").X12ControlNumbers;
const X12Delimiters = @import("x12_delimiters.zig").X12Delimiters;
const X12FunctionalGroupHeaders = @import("x12_functional_group_headers.zig").X12FunctionalGroupHeaders;
const X12GS05TimeFormat = @import("x12_gs05_time_format.zig").X12GS05TimeFormat;
const X12InterchangeControlHeaders = @import("x12_interchange_control_headers.zig").X12InterchangeControlHeaders;

/// A structure containing the details for an outbound EDI object.
pub const X12OutboundEdiHeaders = struct {
    /// Specifies control number configuration for outbound X12 EDI headers. These
    /// settings determine the starting values for interchange, functional group,
    /// and transaction set control numbers.
    control_numbers: ?X12ControlNumbers,

    /// The delimiters, for example semicolon (`;`), that separates sections of the
    /// headers for the X12 object.
    delimiters: ?X12Delimiters,

    /// The functional group headers for the X12 object.
    functional_group_headers: ?X12FunctionalGroupHeaders,

    gs_05_time_format: ?X12GS05TimeFormat,

    /// In X12 EDI messages, delimiters are used to mark the end of segments or
    /// elements, and are defined in the interchange control header.
    interchange_control_headers: ?X12InterchangeControlHeaders,

    /// Specifies whether or not to validate the EDI for this X12 object: `TRUE` or
    /// `FALSE`. When enabled, this performs both standard EDI validation and
    /// applies any configured custom validation rules including element length
    /// constraints, code list validations, and element requirement checks.
    /// Validation results are returned in the response validation messages.
    validate_edi: ?bool,

    pub const json_field_names = .{
        .control_numbers = "controlNumbers",
        .delimiters = "delimiters",
        .functional_group_headers = "functionalGroupHeaders",
        .gs_05_time_format = "gs05TimeFormat",
        .interchange_control_headers = "interchangeControlHeaders",
        .validate_edi = "validateEdi",
    };
};
