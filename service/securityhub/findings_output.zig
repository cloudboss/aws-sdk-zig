const OcsfFindingFilters = @import("ocsf_finding_filters.zig").OcsfFindingFilters;
const FindingsExportFormat = @import("findings_export_format.zig").FindingsExportFormat;
const FindingsSelectableField = @import("findings_selectable_field.zig").FindingsSelectableField;

/// The configuration for a findings export: the output format, an optional set
/// of filters, and the fields to include.
pub const FindingsOutput = struct {
    /// An optional set of OCSF finding filters that restrict which findings are
    /// exported. The filter structure is the same as the one used by
    /// `GetFindingsV2`. If you omit this member, Security Hub exports all findings
    /// available to the caller. When echoed by `GetExportJobV2`, relative date
    /// ranges are returned unresolved.
    filters: ?OcsfFindingFilters = null,

    /// The output format of the export. `CSV` produces comma-separated rows that
    /// are suitable for spreadsheets and analysis tools. `OCSF_JSON` produces
    /// newline-delimited JSON records in the Open Cybersecurity Schema Framework
    /// (OCSF) format used elsewhere in Security Hub.
    format: FindingsExportFormat,

    /// The OCSF finding fields to include in the export, specified as OCSF field
    /// paths (for example, `finding_info.title` or `severity`). You can specify
    /// from 1 to 50 fields.
    ///
    /// Whether this parameter is required depends on the value of `Format`:
    ///
    /// * `CSV` – Required. The field paths that you specify become the columns of
    ///   the output, in the order that you provide them. If you omit this
    ///   parameter, the request returns a `ValidationException`.
    ///
    /// * `OCSF_JSON` – Not supported. This format includes each finding in full, so
    ///   field selection doesn't apply. If you specify this parameter, the request
    ///   returns a `ValidationException`.
    selected_fields: ?[]const FindingsSelectableField = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .format = "Format",
        .selected_fields = "SelectedFields",
    };
};
