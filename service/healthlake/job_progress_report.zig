/// The progress report for the import job.
pub const JobProgressReport = struct {
    /// The transaction rate the import job is processed at.
    throughput: ?f64 = null,

    /// Number of CCDA files successfully transformed during the import's
    /// transformation phase. Populated only for import jobs that use the
    /// two-Step-Function (transformation + ingestion) flow; null for legacy
    /// single-SF imports and for pure FHIR imports that skip transformation.
    total_files_converted: ?i64 = null,

    /// The number of files that failed to be read from the Amazon S3 input bucket
    /// due to customer error.
    total_number_of_files_read_with_customer_error: ?i64 = null,

    /// The number of files imported.
    total_number_of_imported_files: ?i64 = null,

    /// The number of non-FHIR files imported.
    total_number_of_imported_non_fhir_files: ?i64 = null,

    /// The number of non-FHIR files that failed to be read from the Amazon S3 input
    /// bucket due to customer error.
    total_number_of_non_fhir_files_read_with_customer_error: ?i64 = null,

    /// The number of non-FHIR resources imported.
    total_number_of_non_fhir_resources_imported: ?i64 = null,

    /// The number of non-FHIR resources scanned from the Amazon S3 input bucket.
    total_number_of_non_fhir_resources_scanned: ?i64 = null,

    /// The number of non-FHIR resources that failed due to customer error.
    total_number_of_non_fhir_resources_with_customer_error: ?i64 = null,

    /// The number of resources imported.
    total_number_of_resources_imported: ?i64 = null,

    /// The number of resources scanned from the Amazon S3 input bucket.
    total_number_of_resources_scanned: ?i64 = null,

    /// The number of resources that failed due to customer error.
    total_number_of_resources_with_customer_error: ?i64 = null,

    /// The number of files scanned from the Amazon S3 input bucket.
    total_number_of_scanned_files: ?i64 = null,

    /// The number of non-FHIR files scanned from the Amazon S3 input bucket.
    total_number_of_scanned_non_fhir_files: ?i64 = null,

    /// Number of FHIR resources produced by the transformation phase. Populated
    /// only for import jobs that use the two-Step-Function flow; null for legacy
    /// single-SF imports and for pure FHIR imports.
    total_resources_generated: ?i64 = null,

    /// The size (in MB) of files scanned from the Amazon S3 input bucket.
    total_size_of_scanned_files_in_mb: ?f64 = null,

    /// The size (in MB) of non-FHIR files scanned from the Amazon S3 input bucket.
    total_size_of_scanned_non_fhir_files_in_mb: ?f64 = null,

    pub const json_field_names = .{
        .throughput = "Throughput",
        .total_files_converted = "TotalFilesConverted",
        .total_number_of_files_read_with_customer_error = "TotalNumberOfFilesReadWithCustomerError",
        .total_number_of_imported_files = "TotalNumberOfImportedFiles",
        .total_number_of_imported_non_fhir_files = "TotalNumberOfImportedNonFhirFiles",
        .total_number_of_non_fhir_files_read_with_customer_error = "TotalNumberOfNonFhirFilesReadWithCustomerError",
        .total_number_of_non_fhir_resources_imported = "TotalNumberOfNonFhirResourcesImported",
        .total_number_of_non_fhir_resources_scanned = "TotalNumberOfNonFhirResourcesScanned",
        .total_number_of_non_fhir_resources_with_customer_error = "TotalNumberOfNonFhirResourcesWithCustomerError",
        .total_number_of_resources_imported = "TotalNumberOfResourcesImported",
        .total_number_of_resources_scanned = "TotalNumberOfResourcesScanned",
        .total_number_of_resources_with_customer_error = "TotalNumberOfResourcesWithCustomerError",
        .total_number_of_scanned_files = "TotalNumberOfScannedFiles",
        .total_number_of_scanned_non_fhir_files = "TotalNumberOfScannedNonFhirFiles",
        .total_resources_generated = "TotalResourcesGenerated",
        .total_size_of_scanned_files_in_mb = "TotalSizeOfScannedFilesInMB",
        .total_size_of_scanned_non_fhir_files_in_mb = "TotalSizeOfScannedNonFhirFilesInMB",
    };
};
