class CreateCustomerResponseModel {
  final String id;
  final String object;
  final String? address;
  final int balance;
  final int created;
  final String? currency;
  final String? defaultSource;
  final bool delinquent;
  final String? description;
  final String? email;
  final String invoicePrefix;
  final InvoiceSettings invoiceSettings;
  final bool livemode;
  final Map<String, dynamic> metadata;
  final String? name;
  final int nextInvoiceSequence;
  final String? phone;
  final List<String> preferredLocales;
  final String? shipping;
  final String taxExempt;
  final String? testClock;

  CreateCustomerResponseModel({
    required this.id,
    required this.object,
    this.address,
    required this.balance,
    required this.created,
    this.currency,
    this.defaultSource,
    required this.delinquent,
    this.description,
    this.email,
    required this.invoicePrefix,
    required this.invoiceSettings,
    required this.livemode,
    required this.metadata,
    this.name,
    required this.nextInvoiceSequence,
    this.phone,
    required this.preferredLocales,
    this.shipping,
    required this.taxExempt,
    this.testClock,
  });

  factory CreateCustomerResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateCustomerResponseModel(
      id: json['id'],
      object: json['object'],
      address: json['address'],
      balance: json['balance'],
      created: json['created'],
      currency: json['currency'],
      defaultSource: json['default_source'],
      delinquent: json['delinquent'],
      description: json['description'],
      email: json['email'],
      invoicePrefix: json['invoice_prefix'],
      invoiceSettings: InvoiceSettings.fromJson(json['invoice_settings']),
      livemode: json['livemode'],
      metadata: Map<String, dynamic>.from(json['metadata']),
      name: json['name'],
      nextInvoiceSequence: json['next_invoice_sequence'],
      phone: json['phone'],
      preferredLocales: List<String>.from(json['preferred_locales']),
      shipping: json['shipping'],
      taxExempt: json['tax_exempt'],
      testClock: json['test_clock'],
    );
  }
}

class InvoiceSettings {
  final dynamic customFields;
  final String? defaultPaymentMethod;
  final String? footer;
  final dynamic renderingOptions;

  InvoiceSettings({
    this.customFields,
    this.defaultPaymentMethod,
    this.footer,
    this.renderingOptions,
  });

  factory InvoiceSettings.fromJson(Map<String, dynamic> json) {
    return InvoiceSettings(
      customFields: json['custom_fields'],
      defaultPaymentMethod: json['default_payment_method'],
      footer: json['footer'],
      renderingOptions: json['rendering_options'],
    );
  }
}
