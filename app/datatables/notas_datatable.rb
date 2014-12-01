class NotasDatatable
  delegate :params, :l,  :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Nota.count,
      iTotalDisplayRecords: notas.total_entries,
      aaData: data
    }
  end

private

  def data
    notas.map do |nota|
      [
        link_to(nota.tema, nota),
        (nota.descripcion),
        l(nota.fecha_nota),
        l(nota.fecha_ingreso),
        nota.tipo_nota.nombre,
        nota.remitente.alias_or_fullname,
        nota.destinatario.alias_or_fullname,
      ]
    end
  end

  def notas
    @notas ||= fetch_notas
  end

  def fetch_notas
    # notas = Nota.order("#{sort_column} #{sort_direction}")
    # notas = notas.page(page).per_page(per_page)
    # if params[:sSearch].present?
    #   notas = notas.where("name like :search or category like :search", search: "%#{params[:sSearch]}%")
    # end
    # notas
    if params[:sSearch].present?
      notas = Nota.simpleSearch(params[:sSearch])
    else
      notas = Nota.all
    end
    sort = sort_column
    if sort == "remitente"
      notas = notas.joins(:remitente=>:persona).order("personas.nombre, personas.apellido #{sort_direction}")
    elsif sort == "destinatario"
      notas = notas.joins(:destinatario=>:persona).order("personas.nombre, personas.apellido #{sort_direction}")
    else
      notas = notas.order("#{sort} #{sort_direction}")
    end

    notas.page(page).per_page(per_page)
    
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    # columns = %w[fecha released_on price]
    columns = ['tema','descripcion','fecha_nota','fecha_ingreso', 'tipo_nota_id', 'remitente','destinatario']
    #columns [params[:iSortCol_0].to_i]
    columns [params[:order]["0"][:column].to_i]
    
  end

  def sort_direction
    Rails.logger.info("\n\n\n#{params[:order]}SORT\n\n\n\n\n\n\n\n\n")
    #params[:sSortDir_0] == "desc" ? "desc" : "asc"
    params[:order]["0"]["dir"] == "desc" ? "desc" : "asc"
  end
end