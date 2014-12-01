module NotasHelper
  def hashTipo
    {Nota::TIPO_ENTRADA => "Entrada", Nota::TIPO_SALIDA => "Salida"}
  end
    def str_attr_tipo(tipo)
      if tipo == Nota::TIPO_ENTRADA
        return "ENTRADA"
      elsif tipo == Nota::TIPO_SALIDA
        return "SALIDA"
      else
        return "INDEFINIDO"
      end
    end

    def str_attr_estado(estado)
      if estado == Nota::ESTADO_PENDIENTE
        return "PENDIENTE"
      elsif estado == Nota::ESTADO_CIRCULACION
        return "CIRCULACION"
      else
        return "INDEFINIDO"
      end
    end

end
