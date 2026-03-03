/// Details about a Lambda layer version.
pub const AwsLambdaLayerVersionDetails = struct {
    /// The layer's compatible [function
    /// runtimes](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html).
    ///
    /// The following list includes deprecated runtimes. For more information, see
    /// [Runtime deprecation
    /// policy](https://docs.aws.amazon.com/lambda/latest/dg/lambda-runtimes.html#runtime-support-policy) in the *Lambda Developer Guide*.
    ///
    /// Array Members: Maximum number of 5 items.
    ///
    /// Valid Values: `nodejs | nodejs4.3 | nodejs6.10 | nodejs8.10 | nodejs10.x |
    /// nodejs12.x | nodejs14.x | nodejs16.x | java8 | java8.al2 | java11 |
    /// python2.7 | python3.6 | python3.7 | python3.8 | python3.9 | dotnetcore1.0 |
    /// dotnetcore2.0 | dotnetcore2.1 | dotnetcore3.1 | dotnet6 | nodejs4.3-edge |
    /// go1.x | ruby2.5 | ruby2.7 | provided | provided.al2 | nodejs18.x |
    /// python3.10 | java17 | ruby3.2 | python3.11 | nodejs20.x | provided.al2023 |
    /// python3.12 | java21`
    compatible_runtimes: ?[]const []const u8 = null,

    /// Indicates when the version was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    created_date: ?[]const u8 = null,

    /// The version number.
    version: ?i64 = null,

    pub const json_field_names = .{
        .compatible_runtimes = "CompatibleRuntimes",
        .created_date = "CreatedDate",
        .version = "Version",
    };
};
