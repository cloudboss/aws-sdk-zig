const IamPrincipal = @import("iam_principal.zig").IamPrincipal;

/// Union for principal matching. Currently supports IAM principal ARN glob
/// matching.
/// Extensible for future principal types (e.g., OAuth client ID).
pub const MatchPrincipalEntry = union(enum) {
    /// An IAM principal to match against, specified by ARN.
    iam_principal: ?IamPrincipal,

    pub const json_field_names = .{
        .iam_principal = "iamPrincipal",
    };
};
