/// Additional settings for a stateful rule. This is part of the StatefulRule
/// configuration.
pub const RuleOption = struct {
    /// The keyword for the Suricata compatible rule option. You must include a
    /// `sid` (signature ID), and can optionally include other keywords. For
    /// information about Suricata compatible keywords, see [Rule
    /// options](https://suricata.readthedocs.io/en/suricata-7.0.3/rules/intro.html#rule-options) in the Suricata documentation.
    keyword: []const u8,

    /// The settings of the Suricata compatible rule option. Rule options have zero
    /// or more setting values, and the number of possible and required settings
    /// depends on the `Keyword`. For more information about the settings for
    /// specific options, see [Rule
    /// options](https://suricata.readthedocs.io/en/suricata-7.0.3/rules/intro.html#rule-options).
    settings: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .keyword = "Keyword",
        .settings = "Settings",
    };
};
