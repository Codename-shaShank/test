class ReportGenerator
  def self.generate(title, content, publish = false)
    report = Report.create(title: title, content: content)

    if publish
      report.update(published: true)
    end

    report
  end
end