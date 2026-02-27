const BooleanConfigurationOptions = @import("boolean_configuration_options.zig").BooleanConfigurationOptions;
const DoubleConfigurationOptions = @import("double_configuration_options.zig").DoubleConfigurationOptions;
const EnumConfigurationOptions = @import("enum_configuration_options.zig").EnumConfigurationOptions;
const EnumListConfigurationOptions = @import("enum_list_configuration_options.zig").EnumListConfigurationOptions;
const IntegerConfigurationOptions = @import("integer_configuration_options.zig").IntegerConfigurationOptions;
const IntegerListConfigurationOptions = @import("integer_list_configuration_options.zig").IntegerListConfigurationOptions;
const StringConfigurationOptions = @import("string_configuration_options.zig").StringConfigurationOptions;
const StringListConfigurationOptions = @import("string_list_configuration_options.zig").StringListConfigurationOptions;

/// The options for customizing a security control parameter.
pub const ConfigurationOptions = union(enum) {
    /// The options for customizing a security control parameter that is a boolean.
    /// For a boolean parameter, the options are
    /// `true` and `false`.
    boolean: ?BooleanConfigurationOptions,
    /// The options for customizing a security control parameter that is a double.
    double: ?DoubleConfigurationOptions,
    /// The options for customizing a security control parameter that is an enum.
    @"enum": ?EnumConfigurationOptions,
    /// The options for customizing a security control parameter that is a list of
    /// enums.
    enum_list: ?EnumListConfigurationOptions,
    /// The options for customizing a security control parameter that is an integer.
    integer: ?IntegerConfigurationOptions,
    /// The options for customizing a security control parameter that is a list of
    /// integers.
    integer_list: ?IntegerListConfigurationOptions,
    /// The options for customizing a security control parameter that is a string
    /// data type.
    string: ?StringConfigurationOptions,
    /// The options for customizing a security control parameter that is a list of
    /// strings.
    string_list: ?StringListConfigurationOptions,

    pub const json_field_names = .{
        .boolean = "Boolean",
        .double = "Double",
        .@"enum" = "Enum",
        .enum_list = "EnumList",
        .integer = "Integer",
        .integer_list = "IntegerList",
        .string = "String",
        .string_list = "StringList",
    };
};
