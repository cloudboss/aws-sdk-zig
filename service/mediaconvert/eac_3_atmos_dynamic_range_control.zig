/// Specify whether MediaConvert should use any dynamic range control metadata
/// from your input file. Keep the default value, Custom, to provide dynamic
/// range control values in your job settings. Choose Follow source to use the
/// metadata from your input. Related settings--Use these settings to specify
/// your dynamic range control values: Dynamic range compression line and
/// Dynamic range compression RF. When you keep the value Custom for Dynamic
/// range control and you don't specify values for the related settings,
/// MediaConvert uses default values for those settings.
pub const Eac3AtmosDynamicRangeControl = enum {
    specified,
    initialize_from_source,

    pub const json_field_names = .{
        .specified = "SPECIFIED",
        .initialize_from_source = "INITIALIZE_FROM_SOURCE",
    };
};
