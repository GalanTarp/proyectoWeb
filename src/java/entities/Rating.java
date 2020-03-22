/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Alberto
 */
@Entity
@Table(name = "RATING")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Rating.findAll", query = "SELECT r FROM Rating r")
    , @NamedQuery(name = "Rating.findByIdrating", query = "SELECT r FROM Rating r WHERE r.idrating = :idrating")
    , @NamedQuery(name = "Rating.findByPuntos", query = "SELECT r FROM Rating r WHERE r.puntos = :puntos")})
public class Rating implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "IDRATING")
    private Short idrating;
    @Column(name = "PUNTOS")
    private Short puntos;
    @JoinColumn(name = "IDPERSON", referencedColumnName = "ID")
    @ManyToOne
    private Person idperson;
    @JoinColumn(name = "DNI", referencedColumnName = "DNI")
    @ManyToOne
    private Usuario dni;

    public Rating() {
    }

    public Rating(Short idrating) {
        this.idrating = idrating;
    }

    public Short getIdrating() {
        return idrating;
    }

    public void setIdrating(Short idrating) {
        this.idrating = idrating;
    }

    public Short getPuntos() {
        return puntos;
    }

    public void setPuntos(Short puntos) {
        this.puntos = puntos;
    }

    public Person getIdperson() {
        return idperson;
    }

    public void setIdperson(Person idperson) {
        this.idperson = idperson;
    }

    public Usuario getDni() {
        return dni;
    }

    public void setDni(Usuario dni) {
        this.dni = dni;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idrating != null ? idrating.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Rating)) {
            return false;
        }
        Rating other = (Rating) object;
        if ((this.idrating == null && other.idrating != null) || (this.idrating != null && !this.idrating.equals(other.idrating))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.Rating[ idrating=" + idrating + " ]";
    }
    
}
