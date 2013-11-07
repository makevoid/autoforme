module AutoForme
  class ModelTable
    attr_reader :action
    attr_reader :model
    attr_reader :type
    attr_reader :columns
    attr_reader :objs
    attr_reader :opts

    def initialize(action, type, objs, opts={})
      @action = action
      @model = action.model
      @type = type
      @columns = model.columns_for(type)
      @objs = objs
      @opts = opts
    end
    
    def h(s)
      Rack::Utils.escape_html(s.to_s)
    end

    def to_s
      html = "<table class=\"#{model.table_class_for(type)}\">"
      if caption = opts[:caption]
        html << "<caption>#{h caption}</caption>"
      end

      html << "<thead><tr>"
      columns.each do |column|
        html << "<th>#{h model.column_label_for(type, column)}</th>"
      end
      html << "<th>Show</th>" if show = model.supported_action?("show")
      html << "<th>Edit</th>" if edit = model.supported_action?("edit")
      html << "<th>Delete</th>" if delete = model.supported_action?("delete")
      html << "</tr></thead>"

      html << "<tbody>"
      objs.each do |obj|
        html << "<tr>"
        columns.each do |column|
          html << "<td>#{h model.column_value(obj, column)}</td>"
        end
        html << "<td><a href=\"#{action.url_for("show/#{model.primary_key_value(obj)}")}\" class=\"btn btn-mini btn-info\">Show</a></td>" if show
        html << "<td><a href=\"#{action.url_for("edit/#{model.primary_key_value(obj)}")}\" class=\"btn btn-mini btn-primary\">Edit</a></td>" if edit
        html << "<td><a href=\"#{action.url_for("delete/#{model.primary_key_value(obj)}")}\" class=\"btn btn-mini btn-danger\">Delete</a></td>" if delete
        html << "</tr>"
      end
      html << "</tbody></table>"
      html
    end
  end
end
