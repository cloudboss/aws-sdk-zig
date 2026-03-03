/// Describes a custom rewrite or redirect rule.
pub const CustomRule = struct {
    /// The condition for a URL rewrite or redirect rule, such as a country code.
    condition: ?[]const u8 = null,

    /// The source pattern for a URL rewrite or redirect rule.
    source: []const u8,

    /// The status code for a URL rewrite or redirect rule.
    ///
    /// **200**
    ///
    /// Represents a 200 rewrite rule.
    ///
    /// **301**
    ///
    /// Represents a 301 (moved permanently) redirect rule. This and all future
    /// requests should be directed to the target URL.
    ///
    /// **302**
    ///
    /// Represents a 302 temporary redirect rule.
    ///
    /// **404**
    ///
    /// Represents a 404 redirect rule.
    ///
    /// **404-200**
    ///
    /// Represents a 404 rewrite rule.
    status: ?[]const u8 = null,

    /// The target pattern for a URL rewrite or redirect rule.
    target: []const u8,

    pub const json_field_names = .{
        .condition = "condition",
        .source = "source",
        .status = "status",
        .target = "target",
    };
};
