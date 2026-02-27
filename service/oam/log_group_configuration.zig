/// This structure contains the `Filter` parameter which you can use to specify
/// which log groups are to share log events from this source account to the
/// monitoring account.
pub const LogGroupConfiguration = struct {
    /// Use this field to specify which log groups are to share their log events
    /// with the monitoring account. Use the term `LogGroupName` and one or more of
    /// the following operands. Use single quotation marks (') around log group
    /// names. The matching of log group names is case sensitive. Each filter has a
    /// limit of five conditional operands. Conditional operands are `AND` and `OR`.
    ///
    /// * `=` and `!=`
    /// * `AND`
    /// * `OR`
    /// * `LIKE` and `NOT LIKE`. These can be used only as prefix searches. Include
    ///   a `%` at the end of the string that you want to search for and include.
    /// * `IN` and `NOT IN`, using parentheses `( )`
    ///
    /// Examples:
    ///
    /// * `LogGroupName IN ('This-Log-Group', 'Other-Log-Group')` includes only the
    ///   log groups with names `This-Log-Group` and `Other-Log-Group`.
    /// * `LogGroupName NOT IN ('Private-Log-Group', 'Private-Log-Group-2')`
    ///   includes all log groups except the log groups with names
    ///   `Private-Log-Group` and `Private-Log-Group-2`.
    /// * `LogGroupName LIKE 'aws/lambda/%' OR LogGroupName LIKE 'AWSLogs%'`
    ///   includes all log groups that have names that start with `aws/lambda/` or
    ///   `AWSLogs`.
    ///
    /// If you are updating a link that uses filters, you can specify `*` as the
    /// only value for the `filter` parameter to delete the filter and share all log
    /// groups with the monitoring account.
    filter: []const u8,

    pub const json_field_names = .{
        .filter = "Filter",
    };
};
