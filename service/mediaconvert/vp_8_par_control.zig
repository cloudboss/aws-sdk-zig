/// Optional. Specify how the service determines the pixel aspect ratio (PAR)
/// for this output. The default behavior, Follow source, uses the PAR from your
/// input video for your output. To specify a different PAR in the console,
/// choose any value other than Follow source. When you choose SPECIFIED for
/// this setting, you must also specify values for the parNumerator and
/// parDenominator settings.
pub const Vp8ParControl = enum {
    initialize_from_source,
    specified,

    pub const json_field_names = .{
        .initialize_from_source = "INITIALIZE_FROM_SOURCE",
        .specified = "SPECIFIED",
    };
};
